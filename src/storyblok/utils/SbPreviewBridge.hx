package storyblok.utils;

import haxe.DynamicAccess;
import imagsyd.time.EnterFrame;
import js.html.Console;
import js.html.Element;
import js.Browser;
import storyblok.previewApi.SbPreviewAPI;

/**
 * ...
 * @author Thomas Byrne
 */
class SbPreviewBridge 
{
	static public var settings:SbPreviewSettings;
	
	static var complete:Void->Void;

	public static function install(div:Element, token:String, ?complete:Void->Void) : SbPreviewSettings
	{
		settings = getSettings();
		if (settings == null){
			Browser.console.log(SbPreviewBridge, '_storyblok query string doesn\'t exist, aborting Storyblok Bridge install');
			return null;
		}
		
		var scriptTag = Browser.document.createElement('script');
		scriptTag.setAttribute('src','https://app.storyblok.com/f/storyblok-latest.js?t=${token}');
		Browser.document.head.appendChild(scriptTag);
		
		if (complete != null){
			SbPreviewBridge.complete = complete;
			EnterFrame.add(checkReady);
		}
		
		return settings;
	}
	
	static private function checkReady() 
	{
		try{
			SbPreviewAPI.pingEditor(function(){
				if (complete == null) return;
				
				complete();
				complete = null;
				EnterFrame.remove(checkReady);
			});
		}catch(e:Dynamic){}
	}
	
	/*
	 * Example Query string:
	 * 

	_storyblok=477546
	_storyblok_c=life-story
	_storyblok_tk[space_id]=51650
	_storyblok_tk[timestamp]=1546554283
	_storyblok_tk[token]=XXXX
	_storyblok_version=
	_storyblok_release=0
	#default/stories/holly

	*/
	static function getSettings() : SbPreviewSettings {
		var query = Browser.location.search.substring(1);
		if (query.indexOf('_storyblok') == -1) return null;
		
		var vars = query.split('&');
		var ret = untyped {};
		for (i in 0 ... vars.length) {
			var pair = vars[i].split('=');
			switch(pair[0]){
				case '_storyblok': ret.content = Std.parseInt(pair[1]);
				case '_storyblok_c': ret.component = (pair[1]);
				case '_storyblok_tk[space_id]': ret.space = Std.parseInt(pair[1]);
				case '_storyblok_tk[timestamp]': ret.timestamp = Std.parseInt(pair[1]);
				case '_storyblok_tk[token]': ret.token = (pair[1]);
				case '_storyblok_version': ret.version = (pair[1]);
				case '_storyblok_release': ret.release = Std.parseInt(pair[1]);
			}
		}
		ret.slug = Browser.location.hash.substring(1);
		return ret;
	}
	
}

typedef SbPreviewSettings =
{
	slug:String, 		// Full slug of current content
	content:Int, 		// ID of current content
	component:String, 	// Component type of current content
	space:Int, 			// ID of Space
	timestamp:Int, 		// Timestamp when load began
	token:String, 		// A validation token. Combination of space_id, timestamp and your preview_token
	version:String, 	// Version of current content
	release:Int, 		// Release of current content
}