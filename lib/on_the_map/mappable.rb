module OnTheMap
  module Mappable  
    extend ActiveSupport::Concern

    included do
      include ::Gmaps4rails::ActsAsGmappable

      include_concerns :geo_locatable, :positionable, from: 'OnTheMap'

      # see https://github.com/apneadiving/Google-Maps-for-Rails/wiki/Model-Customization
      # https://github.com/apneadiving/Google-Maps-for-Rails/wiki/Mongo%C3%AFd
      acts_as_gmappable position: :position,
                        process_geocoding: :gmaps_geocode?, # 
                        address:"gmaps4rails_address", normalized_address: "normalized_address",
                        msg: "Sorry, not even Google could figure out where that is"

      field :gmaps, type: Boolean

      field :normalized_address # used to save address matched by Google
    end

    # When Geo Coding is to be performed by Gmaps4rails
    # Leave it up to geocoder!
    def gmaps_geocode?
      # has_address? && (has_position? || has_geo_coords?) && 
      false # (!address.blank? && (lat.blank? || lng.blank?)) || position_changed?      
    end

    def has_geo_coords?
      respond_to?(:latitude) && latitude && respond_to?(:longitude) && longitude
    end

    def has_position?
      respond_to?(:position) && position
    end

    def has_address?
      respond_to?(:address) && address
    end

    #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki 
    def gmaps4rails_address
      return address_str if respond_to? :address_str # Use GeoLocatable if such exists
      "#{address.street}, #{address.city}, #{address.country}" 
    end  
  end
end