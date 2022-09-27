module microcms

import net.urllib

pub struct ListParams {
pub mut:
	endpoint string
	draft_key string
	limit    int
	offset   int
	orders   []string
	q        string
	fields   []string
	ids      []string
	filters  string
	depth    int
}

pub struct GetParams {
pub mut:
	endpoint  string
	content_id string
	draft_key  string
	fields    []string
	depth     int
}

fn make_list_query(p ListParams) urllib.Values {
	mut v := urllib.new_values()
	f len(p.draft_key) > 0 {
		v.add("draftKey", p.draft_key)
	}
	if p.Limit != 0 {
		v.add("limit", p.Limit.str())
	}
	if p.offset != 0 {
		v.add("offset", p.offset.str())
	}
	if len(p.orders) > 0 {
		v.add("orders", p.orders.join(","))
	}
	if len(p.q) > 0 {
		v.add("q", p.q)
	}
	if len(p.fields) > 0 {
		v.add("fields", p.fields.join(","))
	}
	if len(p.IDs) > 0 {
		v.add("ids", p.ids.join(","))
	}
	if len(p.filters) > 0 {
		v.add("filters", p.filters)
	}
	if p.depth != 0 {
		v.add("depth", p.depth.str())
	}

}

pub fn (c Client) list<T>(p ListParams) {
	
}
