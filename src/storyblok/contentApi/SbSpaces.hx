package storyblok.contentApi;

import promhx.*;
import storyblok.net.SbHttp;
import storyblok.net.SbOptions;

/**
 * ...
 * @author Thomas Byrne
 */
class SbSpaces
{
	public function new() 
	{
		
	}
	
	static public function current(?options:SbOptions) : Promise<SbSpace>
	{
		return untyped SbHttp.get('/v1/cdn/spaces/me', options, 'space');
	}
}

typedef SbSpace =
{
	name: String,
    domain: String,
    version: Float,
}