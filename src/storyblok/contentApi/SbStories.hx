package storyblok.contentApi;

import promhx.*;
import storyblok.net.SbHttp;
import storyblok.options.SbOptions;
import storyblok.types.*;
import storyblok.options.SbStoriesOptions;
import storyblok.options.SbStoryOptions;

/**
 * ...
 * @author Thomas Byrne
 */
class SbStories
{
	public function new() 
	{
		
	}
	
	static public function list(?options:SbStoriesOptions) : Promise<SbPage<SbStory>>
	{
		return untyped SbHttp.get('/v1/cdn/stories', options, 'stories', PAGE);
	}
	
	static public function listAll(?options:SbStoriesOptions) : Promise<SbPage<SbStory>>
	{
		return untyped SbHttp.getAllPages('/v1/cdn/stories', options, 'stories');
	}
	
	static public function get(idOrPath:String, ?options:SbStoryOptions) : Promise<SbStory>
	{
		return untyped SbHttp.get('/v1/cdn/stories/${idOrPath}', options, 'story');
	}
}