package storyblok.types;

/**
 * ...
 * @author Thomas Byrne
 */
typedef SbStory =
{
	uuid: SbUUID,
	id: Int,
	parent_id: Int,
	
	created_at: SbTimestamp,
	published_at: SbTimestamp,
	first_published_at: SbTimestamp,
	sort_by_date: Null<SbTimestamp>,
	
	name: String,
	alternates: Array<SbStoryAlternate>,
	/*release_id: ??,*/
	content: SbStoryContent,
	slug: String,
	full_slug: String,
	tag_list: Array<String>,
	is_startpage: Bool,
	position: Int,
	lang: String,
	//meta_data: null,
	group_id: SbUUID
}

@:noCompletion
typedef SbStoryAlternate =
{
	id: Int,
	parent_id: Int,
	name: String,
	slug: String,
	full_slug: String,
	is_folder: Bool,
}

@:noCompletion
abstract SbStoryContent(Dynamic) to Dynamic
{
	public var _uid(get, never):SbUUID;
	function get__uid():SbUUID return this._uid;
	
	public var component(get, never):String;
	function get_component():String return this.component;
	
	public function get(name:String) : Dynamic
	{
		return Reflect.field(this, name);
	}
	
}