# API
base_url:  https://texno-gipsy.herokuapp.com

Headers
```json
{
  "user_id": 1,
  "Content-Type": "application/json"
}
```

## Events
**POST /api/client/v1/events**

**PATCH /api/client/v1/events/:id**
Request body:
```json
{
  "title": "ea",
  "description": "Beatae nulla amet facilis.",
  "lon": 2.5,
  "lat": 3.6,
  "radius": 5,
  "tags": [
    "music",
    "movie"
  ],
  "start_at": "2018-12-31T21:00:00Z",
  "end_at": "2019-12-31T21:00:00Z",
  "duration": 5,
  "limit": 10,
  "participants_ids": []
}
```

*Response code: 201*

*Response body:*
```json
{
  "id": 27,
  "title": "ea",
  "description": "Beatae nulla amet facilis.",
  "creator_id": 49,
  "lon": 2.5,
  "lat": 3.6,
  "radius": 5,
  "tags": [
    "music",
    "movie"
  ],
  "start_at": "2018-12-31T21:00:00Z",
  "end_at": "2019-12-31T21:00:00Z",
  "duration": 5,
  "limit": 10,
  "participants_ids": []
}
```

**GET /api/client/v1/events**

*Response code: 200*

*Response body:*
```json
[
  {
    "id": 27,
    "title": "ea",
    "description": "Beatae nulla amet facilis.",
    "creator_id": 49,
    "lon": 2.5,
    "lat": 3.6,
    "radius": 5,
    "tags": [
      "music",
      "movie"
    ],
    "start_at": "2018-12-31T21:00:00Z",
    "end_at": "2019-12-31T21:00:00Z",
    "duration": 5,
    "limit": 10,
    "participants_ids": []
  }
]
```

## Users

**GET /api/client/v1/users**

*Response code: 200*

*Response body:*
```json
[
  {
    "id": 63,
    "name": "Carrie Oakey",
    "instagram": "https://instagram.com/enwordsapp",
    "tags": [
      "music"
    ]
  }
]
```

**GET /api/client/v1/users/:id**

*Response code: 200*

*Response body:*
```json
{
  "id": 63,
  "name": "Carrie Oakey",
  "instagram": "https://instagram.com/enwordsapp",
  "tags": [
    "music"
  ]
}
```

**GET /api/client/v1/users/:id**

*Response code: 200*

*Response body:*
```json
{
  "id": 63,
  "name": "Carrie Oakey",
  "instagram": "https://instagram.com/enwordsapp",
  "tags": [
    "music"
  ]
}
```

**PATCH /api/client/v1/users/:id**

*Request body:*
```json
{
  "name": "Carrie Oakey",
  "instagram": "https://instagram.com/enwordsapp",
  "tags": [
    "movie"
  ]
}
```
*Response code: 200*

*Response body:*
```json
{
  "id": 63,
  "name": "Carrie Oakey",
  "instagram": "https://instagram.com/enwordsapp",
  "tags": [
    "movie"
  ]
}
```
