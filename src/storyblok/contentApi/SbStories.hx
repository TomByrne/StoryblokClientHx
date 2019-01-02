package storyblok.contentApi;

import promhx.*;
import storyblok.net.SbHttp;
import storyblok.net.SbOptions;
import storyblok.types.*;

/**
 * ...
 * @author Thomas Byrne
 */
class SbStories
{
	public function new() 
	{
		
	}
	
	static public function list(?options:SbStoriesOptions) : Promise<SbPage<SbStory>>
	{
		return untyped SbHttp.get('/v1/cdn/stories', options, 'stories', PAGE);
	}
	
	static public function listAll(?options:SbStoriesOptions) : Promise<SbPage<SbStory>>
	{
		return untyped SbHttp.getAllPages('/v1/cdn/stories', options, 'stories');
	}
	
	static public function get(idOrPath:String, ?options:StoryOptions, ?filters:Array<SbFilter>) : Promise<SbStory>
	{
		if (filters != null){
			for (filter in filters){
				var filterStr:String = untyped filter;
				var parts = filterStr.split('=');
				Reflect.setField(options, parts[0], parts[1]);
			}
		}
		return untyped SbHttp.get('/v1/cdn/stories/${idOrPath}', options, 'story');
	}
}

@:noCompletion
typedef SbStoriesOptions =
{
	> SbPageOptions,
	?with_tag: Array<String>,
	?is_startpage: Bool,
	?starts_with: String,
	?by_uuids: Array<SbUUID>,
	?excluding_ids: Array<SbUUID>,
	?excluding_fields: Array<String>,
	?version: SbVersion,
	?cv:Float,
	?sort_by:SbSort,
	?search_term:String,
	?resolve_links:Bool,
	?resolve_relations:Array<String>,
}

typedef StoryOptions =
{
	> SbOptions,
	?find_by: StoryFindBy,
	?version: SbVersion,
	?cv:Float,
	?resolve_links:Bool,
	?resolve_relations:Array<String>,
}

@:noCompletion
@:enum abstract StoryFindBy(String)
{
	var uuid = 'uuid';
}

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