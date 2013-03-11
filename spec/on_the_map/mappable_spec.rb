require 'spec_helper'

require 'rails'
require 'gmaps4rails'

require 'on_the_map/mappable'


class MyMappableAddress
  include Mongoid::Document
#  include OnTheMap::GeoLocatable
  include OnTheMap::Mappable
end


describe OnTheMap::Mappable do
  subject { address }

  context 'empty address' do
    let(:address) { MyMappableAddress.create street: '', city: ''  }

    it 'should have a blank full address' do
      expect(subject.address.full).to be_blank
    end

    it 'should not be geolocatable' do
      expect(subject.geolocatable?).to be false
    end

    it 'should not be geocoded?' do
      expect(subject.geocoded?).to be false
    end

    it 'should not have a gmaps' do
      expect(subject.gmaps).to_not be true
    end

    it 'should not have a normalized address' do
      expect(subject.normalized_address).to be_blank
    end
  end

  context 'invalid address' do
    let(:address) { MyMappableAddress.create street: 'blip blab', city: 'blop'  }

    it 'should be geolocatable' do
      expect(subject.geolocatable?).to be_true
    end

    it 'should not calculate a position' do
      expect(subject.position.to_a).to be_blank
    end

    it 'should not be geocoded?' do
      expect(subject.geocoded?).to be false
    end 

    it 'should not have a gmaps' do
      expect(subject.gmaps).to_not be_true
    end

    it 'should not have a normalized address' do
      expect(subject.normalized_address).to be_blank
    end       
  end

  context 'valid address' do
    let(:address) { MyMappableAddress.create street: street, city: city  }

    let(:city)    { 'Frederiksberg' }
    let(:street)  { 'Maglekildevej 18, 4th' }

    describe 'creation' do
      its(:city)    { should == city }
      its(:street)  { should == street }

      # leave geocoding to geocoder!
      its(:gmaps_geocode?)  { should be_false }    

      # geocoder sets gmaps when position has been calculated?
      # Note: not done anymore
      its(:gmaps)   { should be_false }
    end
  end
end