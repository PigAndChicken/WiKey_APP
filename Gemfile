source 'https://rubygems.org'

# Networking gems
gem 'http'

# Development/Debugging related
# to run console in production
gem 'pry'
gem 'rake'

# Web application related
gem 'econfig'
gem 'puma'
gem 'roda'
gem 'slim'

# Representers
gem 'dry-validation'
gem 'roar'
gem 'multi_json'

# Services
gem 'dry-monads'
gem 'dry-transaction'

group :test do
  gem 'minitest'
  gem 'minitest-rg'
  gem 'rack-test'
  
  gem 'headless'
  gem 'watir'
  gem 'chromedriver-helper', '~> 1.0'
end

group :development, :test do
  gem 'rerun'

  gem 'flog'
  gem 'reek'
  gem 'rubocop'
end

# bundle install --without production
group :production do
  gem 'pg'
end