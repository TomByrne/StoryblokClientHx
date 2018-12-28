package storyblok.types;

/**
 * Acts as a wrapper around using a dynamic object as a map,
 * as is common in JS.
 * 
 * This means it is easily serialisable (unlike Map).
 * 
 * @author Thomas Byrne
 */
abstract SbMap<DataType>(Dynamic) from {}
{
	
	public function new() 
	{
		this = {};
	}
	
	inline public function remove(name:String):Void
	{
		Reflect.deleteField(this, name);
	}
	inline public function get(name:String):DataType
	{
		return untyped this[name];
	}
	inline public function exists(name:String):Bool
	{
		return Reflect.hasField(this, name);
	}
	inline public function set(name:String, value:DataType):Void
	{
		untyped this[name] = value;
	}
	
	inline public function keys():Iterator<String>
	{
		return Reflect.fields(this).iterator();
	}
}