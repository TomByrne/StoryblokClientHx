package storyblok.contentApi;

import promhx.*;
import storyblok.net.SbHttp;
import storyblok.options.SbPageOptions;
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
	
	static public function listAll(?options:SbDatasourcesOptions) : Promise<SbPage<SbDatasource>>
	{
		return untyped SbHttp.getAllPages('/v1/cdn/datasource_entries', options, 'datasource_entries');
	}
}

typedef SbDatasourcesOptions =
{
	> SbPageOptions,
	?datasource:String,
	?dimension:String,
}