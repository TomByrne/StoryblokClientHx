package storyblok.types;

/**
 * ...
 * @author Thomas Byrne
 */
typedef SbLink =
{
	id: Int,
	is_folder: Bool,
	is_startpage: Bool,
	name: String,
	parent_id: Int,
	position: Int,
	published: Bool,
	slug: String,
	uuid: SbUUID,
}