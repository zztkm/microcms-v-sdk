module microcms

import json
import net.urllib
import net.http

// GetContentListParams holds information for retrieve the content list.
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

// GetContentParams holds information for retrieve a single content.
pub struct GetContentParams {
pub mut:
	endpoint           string
	content_id         string
	draft_key          string
	fields             []string
	depth              int
	rich_editor_format string
}

// CreateParams holds information for creating content.
// Note: It does not hold the content itself.
pub struct CreateParams {
pub mut:
	endpoint   string
	content_id string
	status     string
}

// UpdateParams holds information for updating content.
// Note: It does not hold the content itself.
pub struct UpdateParams {
pub mut:
	endpoint   string
	content_id string
}

// DeleteParams holds information for deleting content.
pub struct DeleteParams {
pub mut:
	endpoint   string
	content_id string
}

// CreateResponse holds the response body
// of a successful microCMS content creation.
pub struct CreateResponse {
pub:
	id string
}

// UpdateResponse holds the response body
// of a successful microCMS content update.
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

// content_list is a method to retrieve a content list.
// The retrieved content is stored in the type parameter T and returned.
pub fn (c Client) content_list<T>(p GetContentListParams) ?T {
	req := c.new_request(.get, p.endpoint, make_list_query(p))?

	res := send_request(req)?

	return json.decode(T, res.body)
}

// content is a method to retrieve a single content.
// The retrieved content is stored in the type parameter T and returned.
pub fn (c Client) content<T>(p GetContentParams) ?T {
	req := c.new_request(.get, '$p.endpoint/$p.content_id', make_get_query(p))?

	res := send_request(req)?

	return json.decode(T, res.body)
}

fn make_create_query(p CreateParams) urllib.Values {
	mut v := urllib.new_values()
	if p.status.len > 0 {
		v.add('status', p.status)
	}
	return v
}

// create_content is a method to create content.
// It sends an http request with data as the body.
pub fn (c Client) create_content<T>(p CreateParams, data T) ?CreateResponse {
	mut req := http.Request{}
	query := make_create_query(p)
	content := json.encode(data)
	if p.content_id.len > 0 {
		req = c.new_request(.put, '$p.endpoint/$p.content_id', query)?
	} else {
		req = c.new_request(.post, p.endpoint, query)?
	}
	req.data = content
	res := send_request(req)?
	return json.decode(CreateResponse, res.body)
}

// update_content is a method to update content.
// It sends an http request with data as the body.
pub fn (c Client) update_content<T>(p UpdateParams, data T) ?UpdateResponse {
	req := c.new_request(.patch, '$p.endpoint/$p.content_id', urllib.Values{})?
	content := json.encode(data)
	req.data = content
	res := send_request(req)?
	return json.decode(UpdateResponse, res.body)
}

// delete_content is a method to delete content.
pub fn (c Client) delete_content(p DeleteParams) ? {
	req := c.new_request(.delete, '$p.endpoint/$p.content_id', urllib.Values{})?
	res := send_request(req)?
	return
}
