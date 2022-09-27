module main

import json
import os
import net.http
import zztkm.vdotenv

const (
	base_domain = 'microcms.io'
	api_version = 'v1'
)

struct Content {
	id           string
	created_at   string [json: createdAt]
	updated_at   string [json: updatedAt]
	published_at string [json: publishedAt]
	revised_at   string [json: revisedAt]
	title        string
	content      string
}

struct BlogList {
	contents    []Content
	total_count int       [json: totalCount]
	offset      int
	limit       int
}

fn list<T>() ?T {

	service_domain := os.getenv('SERVICE_DOMAIN')
	api_key := os.getenv('MICROCMS_API_KEY')

	endpoint := 'blogs'

	url := 'https://$service_domain' + '.' + base_domain + '/api/$api_version/$endpoint'

	println("api url: $url")

	mut req := http.Request {
		method: .get
		url: url
	}
	req.add_custom_header('X-MICROCMS-API-KEY', api_key)?

	res := req.do()?
	println("status: $res.status_code.str()")
	if res.status_code >= 400 {
		return error(res.body)
	}

	return json.decode(T, res.body)
}

fn main() {
	// shell environment variables take precedence
	vdotenv.load()

	blogs := list<BlogList>() or {
		eprintln(err)
		return
	}

	println("total contents count: $blogs.total_count")

	println("--- print contents title ---")
	for content in blogs.contents {
		println(content.title)
	}
}
