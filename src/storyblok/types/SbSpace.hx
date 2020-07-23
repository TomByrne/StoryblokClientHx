package storyblok.types;

/**
 * ...
 * @author Thomas Byrne
 */
typedef SbSpace =
{
    id: Int,
	name: String,
    domain: String,
    version: Float,
    ?language_codes:Array<String>,
}