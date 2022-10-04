module main

import os
import zztkm.microcms
import zztkm.vdotenv

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

	c := microcms.new(service_domain, api_key)

	param := microcms.GetContentListParams{
		endpoint: 'blogs'
	}

	blogs := c.content_list<BlogList>(param) or {
		eprintln(err)
		return
	}

	println('total contents count: $blogs.total_count')
	println('--- print content_list title ---')
	mut ids := []string{}
	for content in blogs.contents {
		println('$content.id: $content.title')
		ids << content.id
	}

	println('--- print content title ---')
	for id in ids {
		get_param := microcms.GetContentParams{
			endpoint: 'blogs'
			content_id: id
		}
		content := c.content<Content>(get_param)?
		println('$content.id: $content.title')
	}
	println('end')
}
