package storyblok.types;

/**
 * ...
 * @author Thomas Byrne
 */
abstract SbSort(String)
{

	public function new(field:String, ascending:Bool=true, ?inContent:Bool) 
	{
		this = (inContent ? 'content.' : '') + field + ':' + (ascending ? 'asc' : 'desc');
	}
	
}