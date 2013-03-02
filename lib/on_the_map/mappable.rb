module OnTheMap
  module Mappable  
    extend ActiveSupport::Concern

    included do
      include Gmaps4rails::ActsAsGmappable

      # see https://github.com/apneadiving/Google-Maps-for-Rails/wiki/Model-Customization
      # https://github.com/apneadiving/Google-Maps-for-Rails/wiki/Mongo%C3%AFd
      acts_as_gmappable lat_lng_array: :location,
                        checker: :prevent_geocoding, # 
                        address:"gmaps4rails_address", normalized_address: "normalized_address",
                        msg: "Sorry, not even Google could figure out where that is"

      field :gmaps, type: Boolean

      field :normalized_address # used to save address matched by Google
    end

    # When Geo Coding is to be performed by Gmaps4rails
    def prevent_geocoding
      !address || latitude.blank? || longitude.blank?
    end

    #describe how to retrieve the address from your model, if you use directly a db column, you can dry your code, see wiki 
    def gmaps4rails_address
      return address_str if respond_to? :address_str # Use GeoLocatable if such exists
      "#{address.street}, #{address.city}, #{address.country}" 
    end  
  end
end