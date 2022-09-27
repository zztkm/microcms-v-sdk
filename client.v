module microcms

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

pub fn list() {

}

fn main() {
	println('Hello World!')
}
