require 'mongoid_geospatial'

module OnTheMap
  module Positionable
    extend ActiveSupport::Concern

    included do
      include Mongoid::Geospatial

      geo_field :position

      spatial_index :position
      spatial_scope :position
    end

    def configure_positionable
    end
  end
end