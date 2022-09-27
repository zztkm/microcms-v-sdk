module microcms

import net.http

const (
	base_domain = 'microcms.io'
	api_version = 'v1'
)

struct Client {
	service_domain string
	api_kay string
}

pub fn new(service_domain string, api_kay string) Client {
	client := Client {
		service_domain: service_domain
		api_kay: api_kay
	}
	return client
}

fn (c Client) new_request(method http.Method, endpoint string) ?http.Request {
	url := 'https://$c.service_domain' + '.' + base_domain + '/api/$api_version/$endpoint'

	println("api url: $url")

	mut req := http.Request {
		method: .get
		url: url
	}
	req.add_custom_header('X-MICROCMS-API-KEY', c.api_key) or {
		eprintln("req.add_custom_header error: $err")
		return
	}
}
