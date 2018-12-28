package storyblok.net;

/**
 * ...
 * @author Thomas Byrne
 */
typedef SbOptions =
{
	?token:String,
}
typedef SbPageOptions =
{
	> SbOptions,
	?per_page:Int,
	?page:Int,
}