source "http://rubygems.org"

gem 'mongoid',    '>= 4',     github: 'mongoid/mongoid'
gem 'sugar-high', '~> 0.7.3', github: 'kristianmandrup/sugar-high'

gem 'hashie',     '~> 1.2'
gem 'concerned',  '~> 0.1.3'

gem "rspec",    ">= 2.12.0", group: [:test, :development]

group :test do
  gem 'rails', '>= 4.0.0.beta1', github: 'rails/rails' # '>= 3.1' #
  gem 'geocoder'
  gem 'mongoid_geospatial'
  gem 'mongoid_indexing', '~> 0.1.1', path: '/Users/kmandrup/private/repos/mongoid_indexing'

  gem 'gmaps4rails', '>= 2.0.0.pre', github: 'apneadiving/Google-Maps-for-Rails'
  # gem 'gmaps-autocomplete-rails'  

  # time travel
  # gem 'timecop',  '~> 0.3.5', :git => 'git://github.com/change/timecop.git'
  gem 'delorean', '~> 1.1.1'

  gem 'cutter',   '~> 0.8.2'

  # data store
  gem 'database_cleaner',   '>= 0.8'

  gem 'factory_girl'

  # Fake data
  gem 'ffaker', '>= 1.14'
  gem 'fakeweb'

  gem 'shoulda'         
  gem 'shoulda-matchers'

  # http://railsapps.github.com/tutorial-rails-mongoid-devise.html
  # gem 'mongoid-rspec', '>= 1.7', github: 'evansagge/mongoid-rspec'
end

group :development do
  gem "rdoc",     ">= 3.1"
  gem "bundler",  ">= 1.1.0"
  gem "jeweler",  ">= 1.8.4"
  gem "simplecov",">= 0.5"
end
