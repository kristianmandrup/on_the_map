require 'spec_helper'
require 'on_the_map/geo_locatable'

class MyGeoCodableAddress
  include Mongoid::Document
  include OnTheMap::GeoLocatable
end

describe OnTheMap::GeoLocatable do
  subject { address }

  context 'valid address' do
    let(:address) { MyGeoCodableAddress.create street: street, city: city  }

    let(:city)    { 'Frederiksberg' }
    let(:street)  { 'Maglekildevej 18, 4th' }

    describe 'creation' do
      its(:city)    { should == city }
      its(:street)  { should == street }    

      it 'should be geocoded?' do
        expect(subject.geocoded?).to be true
      end

      its('position.to_a') { should_not be_empty }

      it 'should geocode and calculate latitude' do
        expect(subject.latitude).to be_within(1).of 55
      end

      it 'should geocode and calculate longitude' do
        expect(subject.longitude).to be_within(1).of 12
      end

      context 'after update of street address' do
        before do
          @old_address = subject.dup
          subject.street = 'Gammel kongevej 123'
        end

        describe 'calculated new position' do
          it 'has been updated' do
            expect(subject.position.to_a).to_not eq @old_address.position.to_a
          end

          it 'has new latitude' do
            expect(subject.latitude).to_not eq @old_address.latitude
          end

          it 'has longitude' do
            expect(subject.longitude).to_not eq @old_address.longitude
          end      
        end
      end
    end
  end
end