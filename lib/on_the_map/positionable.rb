require 'mongoid_geospatial'

module OnTheMap
  module Positionable
    extend ActiveSupport::Concern

    included do
      include Mongoid::Geospatial

      geo_field :position, :delegate => true

      spatial_index :position
      spatial_scope :position
    end

    def configure_positionable
    end

    protected

    def longitude= x
      position.x = x
    end

    def latitude= y
      position.y = y
    end
  end
end