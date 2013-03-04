# On The Map

Mongoid concerns for putting models "on the map".

Contains various useful concern modules for: 

* position
* address
* geo-coding
* placing model on a map
* geo spatial indexing of position
* geo spatial searching on position

* Adressable

### Adressable

* embeds an address on the model
* adds delegate methods to all embedded address fields
* adds `full_address` method that returns full adress from concatenation of all fields

### GeoLocatable

* includes `addressable` and `positionable` concerns
* performs geocoding after an address is created or updated
* adds `latitude` and `longitude` methods to model

### Mappable

* include `Gmaps4rails::ActsAsGmappable`
* adds field `normalized_address` to store address calculated and returned by Google Maps geo-coding
* adds method `gmaps4rails_address` which returns main adress for use in geo-coding

### Positionable

* includes `Mongoid::Geospatial` into the model to make GeoSpatial helpers available directly on the model
* Adds geo_field `position` (macro from Mongoid GeoSpatial)
* adds spatial indexing for position field

* positon field is indexed and used in geo-searches (fx find points near a point)

## Usage

```ruby
  include_concerns :addressable,    from: :on_the_map
  include_concerns :mappable,       from: :on_the_map
  include_concerns :positionable,   from: :on_the_map

  include_concerns :geo_locatable,  from: :on_the_map
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

