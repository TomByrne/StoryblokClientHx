package storyblok.options;

import storyblok.types.*;

/**
 * ...
 * @author Thomas Byrne
 */
 
typedef SbStoryOptions =
{
	> SbOptions,
	?find_by: StoryFindBy,
	?version: SbVersion,
	?cv:Float,
	?from_release: String,

	?resolve_links:Bool,
	?resolve_relations:Array<String>,
	
	?language: String,
	?fallback_lang: String,
}

@:noCompletion
@:enum abstract StoryFindBy(String)
{
	var uuid = 'uuid';
}