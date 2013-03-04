# On The Map

Mongoid concerns for putting models "on the map".

Contains various useful concern modules for: 

* position
* address
* geo-coding
* placing model on a map
* geo spatial indexing of position
* geo spatial searching on position

The code examples below use the concerned gem to include the concern modules into a class.
You can use a simple `include OnTheMap::XXXX` in its place or some other concern related API of your choice.

### Adressable

* embeds an `address` on the model
* adds delegate methods to all embedded address fields (setters/getters)
* adds `full_address` method that returns full adress from concatenation of all fields

Address fields: `city, state, state_code, province, province_code, postal_code, country, country_code`

```ruby
class MyModel
  include Mongoid::Document

  include_concern :addressable, from: :on_the_map
end
```

### GeoLocatable

* includes `addressable` and `positionable` concerns
* performs geocoding to calculate new position after an address is created or updated
* adds `latitude` and `longitude` to model

```ruby
class MyModel
  include Mongoid::Document

  include_concerns :geo_locatable, from: 'OnTheMap'
end
```

### Mappable

* include `Gmaps4rails::ActsAsGmappable`
* adds field `normalized_address` to store full address calculated and returned by Google Maps geo-coding
* adds method `gmaps4rails_address` which returns adress used in gmaps geo-coding (if enabled)
* includes `geo_locatable` and `positionable` concerns.

```ruby
class MyModel
  include Mongoid::Document

  include_concerns :mappable, from: 'OnTheMap'
end
```

### Positionable

* includes `Mongoid::Geospatial` into the model to make GeoSpatial methods available
* Adds geo_field `position` (macro from Mongoid GeoSpatial)
* adds spatial indexing for position field
* positon field is indexed and used in geo-searches (fx find points near a point)

```ruby
class MyModel
  include Mongoid::Document

  include_concerns :positionable, from: 'OnTheMap'
end
```

See the specs for examples on how to use these concerns. 

Note: There is room for improvement ;)

## Contributing to on_the_map
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet.
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it.
* Fork the project.
* Start a feature/bugfix branch.
* Commit and push until you are happy with your contribution.
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2013 Kristian Mandrup. See LICENSE.txt for
further details.

