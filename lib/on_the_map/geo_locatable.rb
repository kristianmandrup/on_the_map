require 'on_the_map/addressable'
require 'on_the_map/positionable'

module OnTheMap
  module GeoLocatable
    extend ActiveSupport::Concern

    included do
      include_concerns :addressable, :positionable, from: 'OnTheMap'
      
      include Geocoder::Model::Mongoid

      after_create :perform_geocoding
      after_update :perform_geocoding

      field :geocoded, type: Boolean, default: false
      alias_method :geocoded?, :geocoded

      geocoded_by :full_address, coordinates: :position, skip_index: true do |obj,results|
        if geo = results.first 
          if geo.latitude && geo.longitude
            obj.geocoding_started!

            Address.geo_address_fields.each do |fname|
              geo_value = geo.send fname
              obj.send("#{fname}=", geo_value) unless geo_value.blank?
            end

            obj.position = [geo.longitude, geo.latitude]

            obj.geocoded = true

            # apparently not needed! (according to author of gmaps4rails)
            # if obj.respond_to? :gmaps
            #   obj.gmaps = true 
            # end

            obj.geocoding_done!
          end
        end        
      end

      # after_validation :geocode

      # reverse_geocoded_by :latitude, :longitude #, :address => :full_address

      # FROM: https://github.com/alexreisner/geocoder

      # reverse_geocoded_by :coordinates
      # after_validation :reverse_geocode  # auto-fetch address
      # Once you've set up your model you'll need to create the necessary spatial indices in your database:

      # rake db:mongoid:create_indexes
      # Be sure to read Latitude/Longitude Order in the Notes on MongoDB section below on how to properly retrieve latitude/longitude coordinates from your objects.      
    end

    def latitude
      perform_geocoding unless position
      position[1] if position
    end
    alias_method :lat, :latitude

    def longitude
      perform_geocoding unless position
      position[0] if position
    end
    alias_method :lng, :longitude

    def geocodable?
      !position && geolocatable? || address.changed?
    end

    def geolocatable?
      address && address.geolocatable?
    end

    def perform_geocoding
      geocode if geocodable? && !geocoding?
    end
    alias_method :perform_geocoding!, :perform_geocoding

    def geocoding?
      @geocoding_started == true
    end

    protected

    def geocoding_started!
      @geocoding_started = true
    end

    def geocoding_done!
      @geocoding_started = false
    end
  end
end