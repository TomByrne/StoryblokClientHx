package storyblok.types;

/**
 * ...
 * @author Thomas Byrne
 */
@:enum abstract SbVersion(String)
{
	var DRAFT = 'draft';
	var PUBLISHED = 'published';
}