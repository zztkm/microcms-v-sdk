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

fn main() {
	// shell environment variables take precedence
	vdotenv.load()

	service_domain := os.getenv('SERVICE_DOMAIN')
	api_key := os.getenv('MICROCMS_API_KEY')

	endpoint := 'blogs'

	url := 'https://$service_domain' + '.' + base_domain + '/api/$api_version/$endpoint'

	println("api url: $url")

	mut req := http.Request {
		method: .get
		url: url
	}
	req.add_custom_header('X-MICROCMS-API-KEY', api_key) or {
		eprintln("req.add_custom_header error: $err")
		return
	}

	res := req.do() or {
		eprintln('req.do error: $err')
		return
	}

	println("res status: $res.status()")

	blogs := json.decode(BlogList, res.body) or {
		eprintln('failed to decode json, error: $err')
		return
	}
	println("total contents count: $blogs.total_count")

	println("--- print contents title ---")
	for content in blogs.contents {
		println(content.title)
	}
}
