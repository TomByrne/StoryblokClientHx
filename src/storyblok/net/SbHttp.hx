package storyblok.net;
import promhx.*;
import haxe.Http;
import haxe.Json;
import storyblok.options.*;
import storyblok.types.*;

/**
 * ...
 * @author Thomas Byrne
 */
class SbHttp 
{
	static public var defaultOptions:Dynamic = {};
	
	static public function getAllPages(endpoint:String, ?options:SbPageOptions, ?resProp:String) : Promise<Dynamic>
	{
		var deferred = new Deferred();
		
		var all:SbPage<Dynamic> = {results:[], totalItems:0, totalPages:1, pageSize:0, page:0};
		
		options.page = 0;
		options.per_page = 100;
		
		get(endpoint, options, resProp, SbResposeType.PAGE)
		.then(onPageLoad.bind(_, endpoint, options, resProp, all, deferred))
		.catchError(onPageError.bind(_, deferred));
		
		return new Promise(deferred);
	}
	
	static function onPageError(err:String, deferred:Deferred<Dynamic>) 
	{
		deferred.throwError(err);
	}
	static function onPageLoad(res:SbPage<Dynamic>, endpoint:String, options:SbPageOptions, resProp:String, all:SbPage<Dynamic>, deferred:Deferred<Dynamic>) 
	{
		if (options.page == 0){
			all.totalItems = res.totalItems;
			all.pageSize = res.totalItems;
		}
		all.results = all.results.concat(res.results);
		
		if (all.results.length == all.totalItems){
			deferred.resolve(all);
		}else{
			options.page++;
			get(endpoint, options, resProp, SbResposeType.PAGE)
				.then(onPageLoad.bind(_, endpoint, options, resProp, all, deferred))
				.catchError(onPageError.bind(_, deferred));
		}
	}

	static public function get(endpoint:String, ?options:SbOptions, ?resProp:String, ?type:SbResposeType) : Promise<Dynamic>
	{
		if (type == null) type = SbResposeType.OBJECT;
		
		var deferred = new Deferred();
		
		if (options == null){
			options = untyped defaultOptions;
		}else{
			copyNonExistantProps(options, defaultOptions);
		}
		
		var url = buildUrl(endpoint, options);
		tink.http.Fetch.fetch(url).all()
		.handle(function(o) switch o {
			case Success(res):
				var body = res.body.toString();
				var data:{} = Json.parse(body);
				if (resProp != null) data = Reflect.field(data, resProp);
				
				switch(type){
					case SbResposeType.OBJECT | SbResposeType.ID_MAP: // ignore
					case SbResposeType.PAGE:
						var totalStr:Null<String> = res.header.get('total')[0];
						var totalItems:Int;
						if (totalStr != null){
							totalItems = Std.parseInt(totalStr);
						}else{
							totalItems = untyped data.length;
						}
						
						var page:Null<Int> = Reflect.field(options, 'page');
						if (page == null) page = 0;
						
						var pageSize:Null<Int> = Reflect.field(options, 'per_page');
						if (pageSize == null) pageSize = 25;
						
						var page:SbPage<Dynamic> = {
							results: untyped data,
							
							totalItems: totalItems,
							totalPages: Math.ceil(totalItems / pageSize),
							pageSize: pageSize,
							page: page,
						}
						data = page;
				}
				deferred.resolve(data);
				
			case Failure(e):
				deferred.throwError(e);
		});
		
		return new Promise(deferred);
	}
	
	static function buildUrl(endpoint:String, options:SbOptions) : String
	{
		var url:String = 'https://api.storyblok.com${endpoint}';
		if(options != null)
		{
			var query:String = '';
			for(field in Reflect.fields(options))
			{
				var value:Dynamic = Reflect.field(options, field);
				if(query.length > 0) query += '&';
				query += field + '=' + switch(Type.typeof(value))
				{
					case TBool: (value ? '1' : '0');
					default: Std.string(value);
				}
			}
			if(query.length > 0)
			{
				url += '?' + query;
			}
		}
		return url;
	}
	
	
	static public function copyNonExistantProps(to:{}, from:{}){
		for (field in Reflect.fields(from)){
			var toValue:Dynamic = Reflect.field(to, field);
			if (toValue != null) continue;
			Reflect.setField(to, field, Reflect.field(from, field));
		}
	}
	static public function isArray(v:Dynamic) : Bool
	{
		switch(Type.typeof(v)){
			case TClass(Array):
				return true;
			default:
				return false;
		}
	}
}

@:noCompletion
enum SbResposeType
{
	OBJECT;
	PAGE;
	ID_MAP;
}