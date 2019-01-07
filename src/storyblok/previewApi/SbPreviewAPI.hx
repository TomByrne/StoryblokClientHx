package storyblok.previewApi;

import storyblok.types.*;
import storyblok.options.*;
import haxe.extern.EitherType;

/**
 * ...
 * @author Thomas Byrne
 * 
 * https://www.storyblok.com/docs/Guides/storyblok-latest-js
 */
@:native('storyblok')
extern class SbPreviewAPI 
{

	public static function on(event:EitherType<SbBridgeEvents, Array<SbBridgeEvents>>, handler:SbBridgeEvent->Void) : Void;
	public static function init(config:{accessToken:String}) : Void;
	public static function pingEditor(success:Void->Void) : Void;
	public static function isInEditor() : Bool;
	public static function get(query:SbPreviewStoryOptions, success:{story:SbStory}->Void, error:Dynamic->Void) : Bool;
	public static function getAll(query:SbStoriesOptions, success:{stories:SbStory}->Void, error:Dynamic->Void) : Bool;
	
}

typedef SbPreviewStoryOptions =
{
	> SbStoryOptions,
	slug:String
}

typedef SbBridgeEvent =
{
	?event:String, // For 'customEvent'
	?slugChanged:Bool,
	?story:SbStory,
	?storyId:String,
	?reload:Bool,
}

@:enum abstract SbBridgeEvents(String)
{
	var input = 'input';	//after a user changes the value of a field
	var change = 'change';	//after the user saves the content
	var published = 'published';	//after the user clicks publish
	var unpublished = 'unpublished';	//after the user clicks unpublish
	var enterEditmode = 'enterEditmode';	//after the editor has been initialized in the editmode
	var customEvent = 'customEvent';	//custom event used by third party plugins
}