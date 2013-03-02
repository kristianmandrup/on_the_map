require 'address'

module OnTheMap
  module Addressable
    extend ActiveSupport::Concern

    included do
  		embeds_one :address,  as: :addressable

      Address.address_fields.each do |fname|      
        delegate fname, to: :address

        meth_name = "#{fname}="

        define_method meth_name do |value|
          # create new empty address if none defined
          self.address ||= Address.new 

          # set address field
          self.address.send(meth_name, value)        

          # update full address
          self.address.send :set_full

          perform_geocoding if perform_geocoding? fname

          address.save!
        end
      end

      delegate :region, to: :address              
    end

    def perform_geocoding? name
      return unless respond_to? :perform_geocoding
      geocode_field?(name)    
    end

    def set_address hash
      adr = Hashie::Mash.new hash
      Address.address_fields.each do |name|
        self.send("#{name}=", adr.send(name)) if adr.send(name)
      end
    end

    def full_address
      self.address.full
    end  

    def floor_adr= adr
      self.address.floor_adr = adr if address
    end

    protected

    def geocode_field? name
      [:city, :region].include? name.to_sym
    end
  end
end