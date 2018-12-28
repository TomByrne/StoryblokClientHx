package storyblok.types;
import storyblok.types.SbTimestamp;

/**
 * ...
 * @author Thomas Byrne
 */
abstract SbFilter(String)
{

	public static function terms(attribute:String, op:SBFilterTermsOp, terms:Array<String>) 
	{
		return 'filter_query[${attribute}][${op}]=${terms.join(",")}';
	}
	
	public static function date(attribute:String, op:SBFilterDateOp, date:SbTimestamp) 
	{
		return 'filter_query[${attribute}][${op}]=${date}';
	}
	
}

@:enum abstract SBFilterTermsOp(String)
{
	var in_ = 'in';						// - Contains one of the values of a string value
	var all_in_array = 'all_in_array';	// - Contains all of the values of an array value
	var in_array = 'in_array';			// - Contains any of the values of an array value
	var gt_int = 'gt-int';				// - Greater than integer value
	var lt_int = 'lt-int';				// - Less than integer value
	var gt_float = 'gt-float';			// - Greater than float value
	var lt_float = 'lt-float';			// - Less than float value
}

@:enum abstract SBFilterDateOp(String)
{
	var gt_date = 'gt-date';			// - Greater than date (Format: 2018-03-03 10:00)
	var lt_date = 'lt-date';			// - Less than date
}