module GeocodeStubbing
  def self.stub_geocoding!
    StubGeocodeLookups.new
  end
end

class StubGeocodeLookups
  def initialize
    Geocoder.configure(:lookup => :test)
    configure
  end

  def configure
    add_stubs :invalid_adr, :maglekildevej, :gammel_kongevej
  end

  protected

  def add_stubs *stubs
    stubs.flatten.each {|stub| add_stub stub }
  end

  def add_stub stub
    stubber = stub_class(stub).new

    stubber.places.flatten.each do |place|
      Geocoder::Lookup::Test.add_stub place, [stubber.result]
    end
  end

  def stub_class name
    "StubGeocodeLookups::#{name.to_s.camelize}".constantize
  end

  def resolve *stubs
    [stubs].flatten.map {|stub| send(stub) }
  end  

  class Stubber
  end

  class InvalidAdr < Stubber
    def result
      {
    'latitude'     => nil,
    'longitude'    => nil,
    'address'      => nil,
    'state'        => nil,
    'state_code'   => nil,
    'country'      => nil,
    'country_code' => nil
      }
    end

    def places
      ["blip blab", "blip blab, blop", "blip blab, blop, DK"]
    end    
  end

  class Maglekildevej < Stubber
    def result 
      {
      'latitude'     => 55.677069,
      'longitude'    => 12.513321,
      'address'      => 'Maglekildevej 18, 4th, Frederiksberg, Copenhagen, Denmark',
      'state'        => '',
      'state_code'   => '',
      'country'      => 'Denmark',
      'country_code' => 'DK'
      }
    end

    def places
      [
        "Maglekildevej 18, 4th",
        "Maglekildevej 18, 4th, Frederiksberg",
        "Maglekildevej 18, 4th, Denmark, DK",
        "Maglekildevej 18, 4th, Frederiksberg, DK",
        "Maglekildevej 18, 4th, Frederiksberg, Denmark, DK"
      ]
    end    
  end

  class GammelKongevej < Stubber
    def result
      {
      'latitude'     => 55.67616169999999,
      'longitude'    => 12.5422907,
      'address'      => 'Gammel kongevej 123, Frederiksberg, Copenhagen, Denmark',
      'state'        => '',
      'state_code'   => '',
      'country'      => 'Denmark',
      'country_code' => 'DK'
      }
    end

    def places
      [
        "Gammel kongevej 123", 
        "Gammel kongevej 123, Frederiksberg", 
        "Gammel kongevej 123, Frederiksberg, DK",
        "Gammel kongevej 123, Frederiksberg, Denmark, DK"
      ]
    end
  end    
end