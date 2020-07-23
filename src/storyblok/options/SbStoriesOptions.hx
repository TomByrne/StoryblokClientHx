package storyblok.options;

import storyblok.options.SbOptions;
import storyblok.types.*;

/**
 * ...
 * @author Thomas Byrne
 */
@:forward()
abstract SbStoriesOptions(SbStoriesOptionsBase) from SbStoriesOptionsBase to SbStoriesOptionsBase
{
	
	public function addTermsFilter(attribute:String, op:SBFilterTermsOp, terms:Array<String>) 
	{
		Reflect.setField(this, 'filter_query[${attribute}][${op}]', '${terms.join(",")}');
	}
	
	public function addDateFilter(attribute:String, op:SBFilterDateOp, date:SbTimestamp) 
	{
		Reflect.setField(this, 'filter_query[${attribute}][${op}]', '${date}');
	}
}
@:noCompletion
typedef SbStoriesOptionsBase =
{
	> SbPageOptions,
	?with_tag: Array<String>,
	?is_startpage: Bool,
	?starts_with: String,
	?version: SbVersion,
	?cv:Float,
	?sort_by:SbSort,
	?search_term:String,
	?from_release:String,

	?first_published_at_gt: SbTimestamp,
	?first_published_at_lt: SbTimestamp,
	?published_at_gt: SbTimestamp,
	?published_at_lt: SbTimestamp,

	?by_uuids: Array<SbUUID>,
	?by_uuids_ordered: Array<SbUUID>,
	?by_slugs: Array<String>,

	?excluding_ids: Array<SbUUID>,
	?excluding_fields: Array<String>,
	?excluding_slugs: Array<String>,

	?fallback_lang: String,

	?resolve_links:Bool,
	?resolve_relations:Array<String>,
	?resolve_assets:Bool,
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