module microcms

import net.http
import net.urllib

const (
	base_domain = 'microcms.io'
	api_version = 'v1'
)

struct Client {
	service_domain string
	api_key        string
}

pub fn new(service_domain string, api_key string) Client {
	client := Client{
		service_domain: service_domain
		api_key: api_key
	}
	return client
}

fn (c Client) new_request(method http.Method, endpoint string, query urllib.Values) ?http.Request {
	mut url := 'https://$c.service_domain' + '.' + microcms.base_domain +
		'/api/$microcms.api_version/$endpoint'

	if query.len > 0 {
		url = url + '?' + query.encode()
	}

	mut req := http.Request{
		method: .get
		url: url
	}
	req.add_custom_header('X-MICROCMS-API-KEY', c.api_key)?
	return req
}

fn send_request(req http.Request) ?http.Response {
	res := req.do()?

	if res.status_code >= 400 {
		return error(res.body)
	}

	return res
}
