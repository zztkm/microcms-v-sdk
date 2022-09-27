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
	vdotenv.load()

	service_domain := os.getenv('SERVICE_DOMAIN')
	api_key := os.getenv('MICROCMS_API_KEY')

	endpoint := 'blogs'

	url := 'https://$service_domain' + '.' + base_domain + '/api/$api_version/$endpoint'

	println(url)

	custome_header_map := {
		'X-MICROCMS-API-KEY': api_key,
	}
	header := http.new_custom_header_from_map(custome_header_map) or {
		eprintln('new_custom_header_from_map error: $err')
		return
	}
	fetch_config := http.FetchConfig {
		url: url
		method: .get
		header: header
	}
	res := http.fetch(fetch_config) or {
		eprintln('http.fetch error: $err')
		return
	}

	println(res.status())

	blogs := json.decode(BlogList, res.body) or {
		eprintln('failed to decode json, error: $err')
		return
	}
	println(blogs.total_count)

	for content in blogs.contents {
		println(content.title)
	}
}
