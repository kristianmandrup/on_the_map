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

      geocoded_by :full_address, coordinates: :position, skip_index: true

      # reverse_geocoded_by :latitude, :longitude #, :address => :full_address
    end

    def latitude
      perform_geocoding unless position
      position[1] if position
    end

    def longitude
      perform_geocoding unless position
      position[0] if position
    end

    protected

    def perform_geocoding
      geocode if geocodable?
    end

    def geocodable?
      !position && address_geolocatable? || address.changed?
    end

    def address_geolocatable?
      address && !address.full.blank?
    end
  end
end