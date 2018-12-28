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
	
	static public function list(?options:StoriesOptions) : Promise<SbPage<SbStory>>
	{
		return untyped SbHttp.get('/v1/cdn/stories', options, 'stories', PAGE);
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
typedef StoriesOptions =
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
	id: Int,
	parent_id: Int,
	
	name: String,
	created_at: SbTimestamp,
	published_at: SbTimestamp,	
	/*alternates: Array<??>,*/
	uuid: SbUUID,
	content: SbStoryContent,
	slug: String,
	full_slug: String,
	//sort_by_date: null,
	tag_list: Array<String>,
	is_startpage: Bool,
	//meta_data: null,
	group_id: SbUUID
}

@:noCompletion
typedef SbStoryContent =
{
	_uid:SbUUID,
	//body:Array<??>,
	author:SbUUID,
	headline:String,
	component:String,
}