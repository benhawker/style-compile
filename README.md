
# Style Compile

An API built on Rails 5 that compiles a LESS template into CSS whilst interpolating a selection variables (selected arbitralily for the purpose of this application).

===================

### Setup:

To run locally try the following commands:

```bundle install```
```bundle exec rake db:create```
```bundle exec rake db:migrate```
```bundle exec rails s```

To run the specs:
```bundle exec rspec```

Once you have a server running use `curl` or the easy to use Chrome extension `Postman`

You may want to fire up a rails console `rails c` and run create a `User`.

```User.create!(id: 1, name: "test", email: "test@test.com" }```

Get hold of this user's access_token `(User.last.access_token`) which is created via an ActiveRecord callback.

You can pass HTTP Headers of:

Content-Type => application/json
Authorization => Token your_token

You can then look to makes call to the API

* index
GET http://localhost:3000/v1/stylesheets/

Sample response:

```
[
  {
    "id": 149,
    "url": "/Users/benhawker/Desktop/style_compile/public/stylesheets/bob_7f87.css",
    "created_at": "2016-10-02T09:10:59.923Z",
    "updated_at": "2016-10-02T09:10:59.923Z",
    "user_id": 1,
    "error_message": null,
    "data": "#<File:0x007f830ce7db28>"
  },
  {
    "id": 148,
    "url": "/Users/benhawker/Desktop/style_compile/public/stylesheets/bob_dd15.css",
    "created_at": "2016-10-01T12:57:19.388Z",
    "updated_at": "2016-10-01T12:57:19.388Z",
    "user_id": 1,
    "error_message": null,
    "data": "#<File:0x007fdab622e7d0>"
  }
]
```

* show/id
GET http://localhost:3000/v1/stylesheets/1

```
{
  "id": 148,
  "url": "/Users/benhawker/Desktop/style_compile/public/stylesheets/bob_dd15.css",
  "created_at": "2016-10-01T12:57:19.388Z",
  "updated_at": "2016-10-01T12:57:19.388Z",
  "user_id": 1,
  "error_message": null,
  "data": "#<File:0x007fdab622e7d0>"
}
```

* create
POST http://localhost:3000/v1/stylesheets/

You may find it convient to pass the following JSON on the body of the request.

Sample request body:
```
{
  "brand-success": "123",
  "brand-primary": "153",
  "brand-info" : "124343",
  "brand-danger": "123243",
  "brand-warning": "122343"
}
```

Sample response:

```
{
  "id": 149,
  "url": "/Users/benhawker/Desktop/style_compile/public/stylesheets/bob_7f87.css",
  "created_at": "2016-10-02T09:10:59.923Z",
  "updated_at": "2016-10-02T09:10:59.923Z",
  "user_id": 1,
  "error_message": null,
  "data": "#<File:0x007f830ce7db28>"
}
```






* I M N - Create a new M x N image with all pixels coloured white (O).
* C - Clears the table, setting all pixels to white (O).
* L X Y C - Colours the pixel (X,Y) with colour C.
* V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
* H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
* S - Show the contents of the current image
* ? - Displays help text
* X - Terminate the session
