require 'spec_helper'
require 'on_the_map/addressable'

class MyAddress
  include Mongoid::Document
  include OnTheMap::Addressable
end

class MyGeoCodedAddress
  include Mongoid::Document  
  include OnTheMap::Addressable

  def perform_geocoding
  end
end

describe OnTheMap::Addressable do
  subject { address }

  context 'blank/empty address' do
    let(:address) { MyGeoCodableAddress.create street: '', city: ''  }

    it 'should have a blank full address' do
      expect(subject.address.full).to be_blank
    end

    it 'should not be geolocatable' do
      expect(subject.geolocatable?).to be false
    end
  end

  let(:address) { MyAddress.create street: 'maglekildevej 18, 4th', city: '1853 Frederiksberg C'  }

  context 'without geocoding' do
    Address.address_fields.each do |fname|
      describe fname do
        it 'should return value' do
          expect { subject.send fname }.to_not raise_error
        end
      end    

      describe "#{fname}=" do
        it 'should set value' do
          subject.send("#{fname}=", 'hello')
          expect(subject.send fname).to eq 'hello'
        end
      end    
    end

    describe 'region' do
      it 'should use the field' do
        subject.state = 'denmark'
        expect(subject.region).to match /denmark/
      end
    end

    describe 'full_address' do
      it 'should use the field' do
        subject.street = 'denmark'
        expect(subject.full_address).to match /denmark/
      end
    end

    describe 'set_address' do
      it 'should set the fields' do
        subject.set_address(city: 'barcelona')
        expect(subject.city).to eq 'barcelona'
      end
    end
  end
end