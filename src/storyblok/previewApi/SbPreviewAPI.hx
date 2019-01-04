package storyblok.previewApi;

import storyblok.types.*;
import storyblok.options.*;

/**
 * ...
 * @author Thomas Byrne
 * 
 * https://www.storyblok.com/docs/Guides/storyblok-latest-js
 */
@:native('storyblok')
extern class SbPreviewAPI 
{

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