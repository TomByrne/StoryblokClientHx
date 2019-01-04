package storyblok.contentApi;

import promhx.*;
import storyblok.net.SbHttp;
import storyblok.options.SbOptions;
import storyblok.types.*;

/**
 * ...
 * @author Thomas Byrne
 */
class SbDatasources
{
	public function new() 
	{
		
	}
	
	static public function list(?options:SbDatasourcesOptions) : Promise<SbPage<SbDatasource>>
	{
		return untyped SbHttp.get('/v1/cdn/datasource_entries', options, 'datasource_entries', PAGE);
	}
}

typedef SbDatasourcesOptions =
{
	> SbOptions,
	?datasource:String,
	?dimension:String,
}