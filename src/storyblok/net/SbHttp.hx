package storyblok.net;
import promhx.*;
import haxe.Http;
import haxe.Json;
import storyblok.net.SbOptions;
import storyblok.types.SbPage;

/**
 * ...
 * @author Thomas Byrne
 */
class SbHttp 
{
	static public var defaultOptions:Dynamic = {};

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
		
		var http = new Http(url);
		for (field in Reflect.fields(options)){
			var value:Dynamic = Reflect.field(options, field);
			if (Std.is(value, Bool)){
				value = (value == true ? '1' : '0');
			}else if (isArray(value)){
				var arr:Array<Dynamic> = untyped value;
				value = value.join(',');
			}
			http.setParameter(field, value);
		}
		
		http.onData = function(res:String){
			var data:{} = Json.parse(res);
			if (resProp != null) data = Reflect.field(data, resProp);
			
			switch(type){
				case SbResposeType.OBJECT | SbResposeType.ID_MAP: // ignore
				case SbResposeType.PAGE:
					var page:SbPage<Dynamic> = {
						results: untyped data
					}
					data = page;
			}
			deferred.resolve(data);
		}
		http.onError = function(err:String){
			deferred.throwError(err);
		}
		http.request();
		
		return new Promise(deferred);
	}
	
	static function buildUrl(endpoint:String, options:SbOptions) : String
	{
		return 'https://api.storyblok.com${endpoint}';
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