package storyblok.contentApi;

import promhx.*;
import storyblok.net.SbHttp;
import storyblok.net.SbOptions;
import storyblok.types.*;

/**
 * ...
 * @author Thomas Byrne
 */
class SbTags
{
	public function new() 
	{
		
	}
	
	static public function list(?options:SbTagsOptions) : Promise<SbPage<SbTag>>
	{
		return untyped SbHttp.get('/v1/cdn/tags', options, 'tags', PAGE);
	}
}

typedef SbTagsOptions =
{
	> SbOptions,
	?starts_with:String
}

typedef SbTag =
{
	name: String,
	taggings_count: Int,
}