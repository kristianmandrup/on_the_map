require 'rspec'
require 'on_the_map'

require 'hashie'
require 'concerned'

require 'mongoid'
require 'moped'

require 'factory_girl'

require 'geocoder'

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
# Dir["#{File.dirname(__FILE__)}/support/*.rb"].each {|f| require f}
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  Mongoid.configure do |mongoid_config|
    mongoid_config.connect_to('mongoid_map_test')
  end  

  # Remove this line if you don't want RSpec's should and should_not
  # methods or matchers
  require 'rspec/expectations'
  config.include RSpec::Matchers

  config.include FactoryGirl::Syntax::Methods

  # Stub geocoding
  GeocodeStubbing.stub_geocoding!

  # == Mock Framework
  config.mock_with :rspec

  config.include Mongoid::Matchers

  # Clean up the database
  require 'database_cleaner'
  config.before(:suite) do
    DatabaseCleaner[:mongoid].strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.clean
  end
end    