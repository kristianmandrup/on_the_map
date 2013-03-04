require 'spec_helper'
require 'on_the_map/geo_locatable'

class MyGeoCodableAddress
  include Mongoid::Document
  include OnTheMap::GeoLocatable
end


describe OnTheMap::GeoLocatable do
  subject { address }

  context 'empty address' do
    let(:address) { MyGeoCodableAddress.create street: '', city: ''  }

    it 'should have a blank full address' do
      expect(subject.address.full).to be_blank
    end

    it 'should not be geolocatable' do
      expect(subject.geolocatable?).to be false
    end

    it 'should not be geocoded?' do
      expect(subject.geocoded?).to be false
    end
  end

  context 'invalid address' do
    let(:address) { MyGeoCodableAddress.create street: 'blip blab', city: 'blop'  }

    it 'should be geolocatable' do
      expect(subject.geolocatable?).to be_true
    end

    it 'should not calculate a position' do
      expect(subject.position.to_a).to be_blank
    end

    it 'should not be geocoded?' do
      expect(subject.geocoded?).to be false
    end    
  end
end