require 'spec_helper'

require 'on_the_map/positionable'

require 'rails'
require 'mongoid'
require 'rails/mongoid'

module Dummy
  class Application < Rails::Application
  end
end

require 'mongoid_indexing'

class MyPositionableAddress
  include Mongoid::Document
#  include OnTheMap::GeoLocatable
  include OnTheMap::Positionable
end

describe OnTheMap::Positionable do
  subject { address }

  before :suite do
    Mongoid.logger = Logger.new($stdout)
    Moped.logger   = Logger.new($stdout)
  end

  context 'empty address' do
    let(:address) {   }

    before do
      5.times do |n|
        MyPositionableAddress.create position: [rand(n), n*4]
      end

      ::Mongoid::Indexing.create_indexes
    end

    describe 'positions' do
      before do
        @nearby = MyPositionableAddress.nearby(MyPositionableAddress.first.position)
        # puts "nearby: #{@nearby.to_a.inspect}"
      end

      it 'should have all nearby' do
        expect(@nearby).to have(5).items
      end
    end
  end
end