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
	?resolve_links:Bool,
	?resolve_relations:Array<String>,
}

@:noCompletion
@:enum abstract StoryFindBy(String)
{
	var uuid = 'uuid';
}