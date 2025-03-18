# Pet tracking app with a DDD approach for the database modelling.

Structure & architecture inspired by https://www.visuality.pl/posts/introduction-to-ddd-in-ruby-on-rails

APP logic at https://github.com/samuelgaco/pet_tracking/tree/main/app/modules/pet_tracking

## Setting & running the app:

1. Prerequisites
- Ruby 3.2.2 or higher
- Rails 8.0.1

2. Install dependencies:
```
bundle install
```

3. Start the server:
```
rails server
```

4. Launch test suite with:

```
rspec spec
```

5. Curl testing example:

Create a new pet (`pet_type: String`, `tracket_type: String`, `owner_id: Integer`, `in_zone: boolean`, `lost_tracker: boolean`)

```
curl -X POST http://localhost:3000/pets \   
  -d "pet_type=dog" \
  -d "tracker_type=small" \
  -d "owner_id=1" \
  -d "in_zone=false"
```

Query pets outside zone with:

```
 curl http://localhost:3000/pets/outside_zone
```


```
{"dogs":{"small":1,"medium":0,"big":0},"cats":{"small":0,"big":0}}% 
```



