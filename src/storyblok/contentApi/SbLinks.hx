package storyblok.contentApi;

import promhx.*;
import storyblok.net.SbHttp;
import storyblok.options.SbOptions;
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
	
	static public function get(id:String, ?options:SbOptions) : Promise<SbLink>
	{
		return untyped SbHttp.get('/v1/cdn/links/${id}', options, 'link');
	}
}

typedef SbLinksOptions =
{
	> SbOptions,
	?starts_with:String,
	?version: SbVersion
}