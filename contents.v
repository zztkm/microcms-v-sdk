module microcms

import json
import net.urllib

pub struct GetContentListParams {
pub mut:
	endpoint           string
	draft_key          string
	limit              int
	offset             int
	orders             []string
	q                  string
	fields             []string
	ids                []string
	filters            string
	depth              int
	rich_editor_format string
}

pub struct GetContentParams {
pub mut:
	endpoint           string
	content_id         string
	draft_key          string
	fields             []string
	depth              int
	rich_editor_format string
}

pub struct CreateParams {
pub mut:
	endpoint   string
	content_id string
	status     string
}

pub struct UpdateParams {
pub mut:
	endpoint   string
	content_id string
}

pub struct DeleteParams {
pub mut:
	endpoint   string
	content_id string
}

pub struct CreateResponse {
pub:
	id string
}

pub struct UpdateResponse {
pub:
	id string
}

fn make_list_query(p GetContentListParams) urllib.Values {
	mut v := urllib.new_values()
	if p.draft_key.len > 0 {
		v.add('draftKey', p.draft_key)
	}
	if p.limit != 0 {
		v.add('limit', p.limit.str())
	}
	if p.offset != 0 {
		v.add('offset', p.offset.str())
	}
	if p.orders.len > 0 {
		v.add('orders', p.orders.join(','))
	}
	if p.q.len > 0 {
		v.add('q', p.q)
	}
	if p.fields.len > 0 {
		v.add('fields', p.fields.join(','))
	}
	if p.ids.len > 0 {
		v.add('ids', p.ids.join(','))
	}
	if p.filters.len > 0 {
		v.add('filters', p.filters)
	}
	if p.depth != 0 {
		v.add('depth', p.depth.str())
	}
	if p.rich_editor_format.len > 0 {
		v.add('richEditorFormat', p.rich_editor_format)
	}
	return v
}

fn make_get_query(p GetContentParams) urllib.Values {
	mut v := urllib.new_values()
	if p.draft_key.len > 0 {
		v.add('draftKey', p.draft_key)
	}
	if p.fields.len > 0 {
		v.add('fields', p.fields.join(','))
	}
	if p.depth != 0 {
		v.add('depth', p.depth.str())
	}
	if p.rich_editor_format.len > 0 {
		v.add('richEditorFormat', p.rich_editor_format)
	}
	return v
}

pub fn (c Client) content_list<T>(p GetContentListParams) ?T {
	req := c.new_request(.get, p.endpoint, make_list_query(p))?

	res := send_request(req)?

	return json.decode(T, res.body)
}

pub fn (c Client) content<T>(p GetContentParams) ?T {
	req := c.new_request(.get, p.endpoint, make_get_query(p))?

	res := send_request(req)?

	return json.decode(T, res.body)
}

pub fn (c Client) create_content<T>(p CreateParams, data T) ?CreateResponse {}

pub fn (c Client) update_content<T>(p UpdateParams, data T) ?UpdateResponse {}

pub fn (c Client) delete_content(p DeleteParams) ? {}
