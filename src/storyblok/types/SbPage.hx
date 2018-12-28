package storyblok.types;

/**
 * ...
 * @author Thomas Byrne
 */
typedef SbPage<DataType> =
{
	results:Array<DataType>,
	
	totalItems:Int,
	totalPages:Int,
	pageSize:Int,
	page:Int,
	
}