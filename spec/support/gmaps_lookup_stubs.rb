Geocoder.configure(:lookup => :test)

Invalid_adr = {
  'latitude'     => nil,
  'longitude'    => nil,
  'address'      => nil,
  'state'        => nil,
  'state_code'   => nil,
  'country'      => nil,
  'country_code' => nil
}

# Invalid

Geocoder::Lookup::Test.add_stub(
  "blip blab", [Invalid_adr]
)

Geocoder::Lookup::Test.add_stub(
  "blip blab, blop", [Invalid_adr]
)

Geocoder::Lookup::Test.add_stub(
  "blip blab, blop, DK", [Invalid_adr]
)

Maglekildevej = {
  'latitude'     => 55.677069,
  'longitude'    => 12.513321,
  'address'      => 'Maglekildevej 18, 4th, Frederiksberg, Copenhagen, Denmark',
  'state'        => '',
  'state_code'   => '',
  'country'      => 'Denmark',
  'country_code' => 'DK'
}

Gammel_kongevej = {
  'latitude'     => 55.67616169999999,
  'longitude'    => 12.5422907,
  'address'      => 'Gammel kongevej 123, Frederiksberg, Copenhagen, Denmark',
  'state'        => '',
  'state_code'   => '',
  'country'      => 'Denmark',
  'country_code' => 'DK'
}

# Gammel kongevej

Geocoder::Lookup::Test.add_stub(
  "Gammel kongevej 123, Frederiksberg", [Gammel_kongevej]
)

Geocoder::Lookup::Test.add_stub(
  "Gammel kongevej 123", [Gammel_kongevej]
)

Geocoder::Lookup::Test.add_stub(
  "Gammel kongevej 123, Frederiksberg, DK", [Gammel_kongevej]
)

Geocoder::Lookup::Test.add_stub(
  "Gammel kongevej 123, Frederiksberg, Denmark, DK", [Gammel_kongevej]
)


# Maglekildevej

Geocoder::Lookup::Test.add_stub(
  "Maglekildevej 18, 4th, Frederiksberg", [Maglekildevej]
)

Geocoder::Lookup::Test.add_stub(
  "Maglekildevej 18, 4th", [Maglekildevej]
)

Geocoder::Lookup::Test.add_stub(
  "Maglekildevej 18, 4th, Denmark, DK", [Maglekildevej]
)

Geocoder::Lookup::Test.add_stub(
  "Maglekildevej 18, 4th, Frederiksberg, Denmark, DK", [Maglekildevej]
)

Geocoder::Lookup::Test.add_stub(
  "Maglekildevej 18, 4th, Frederiksberg, DK", [Maglekildevej]
)