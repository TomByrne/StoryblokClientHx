package storyblok.contentApi;

import promhx.*;
import storyblok.net.SbHttp;
import storyblok.net.SbOptions;
import storyblok.types.*;

/**
 * ...
 * @author Thomas Byrne
 */
class SbLinks
{
	public function new() 
	{
		
	}
	
	static public function list(?options:SbLinksOptions) : Promise<SbMap<SbLink>>
	{
		return untyped SbHttp.get('/v1/cdn/links', options, 'links', ID_MAP);
	}
}

typedef SbLinksOptions =
{
	> SbOptions,
	?starts_with:String,
	?version: SbVersion
}

typedef SbLink =
{
	name: String,
	taggings_count: Int,
}