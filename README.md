# microCMS sdk for v

[microCMS](https://microcms.io/) sdk for v language.

## Installation and Import

### Using vpm

Install / Update module:

```shell
v install zztkm.microcms
```

Import

```v
import zztkm.microcms
```

## Usage

TODO: 使い方をがんばって記載する

## APIs

Content API
- [x] [GET /api/v1/{endpoint}](https://document.microcms.io/content-api/get-list-contents)
- [x] [GET /api/v1/{endpoint}/{content_id}](https://document.microcms.io/content-api/get-content)
- [x] [POST /api/v1/{endpoint}](https://document.microcms.io/content-api/post-content)
- [x] [PUT /api/v1/{endpoint}/{content_id}](https://document.microcms.io/content-api/put-content)
- [x] [PATCH /api/v1/{endpoint}/{content_id}](https://document.microcms.io/content-api/patch-content)
- [x] [DELETE /api/v1/{endpoint}/{content_id}](https://document.microcms.io/content-api/delete-content)

Management API
- [ ] [GET /api/v1/contents/{endpoint}](https://document.microcms.io/management-api/get-list-contents-management)
- [ ] [GET /api/v1/contents/{endpoint}/{content_id}](https://document.microcms.io/management-api/get-content)
- [ ] [PATCH /api/v1/contents/{endpoint}/{content_id}/status](https://document.microcms.io/management-api/patch-contents-status)
- [ ] [GET /api/v1/media](https://document.microcms.io/management-api/get-media)
