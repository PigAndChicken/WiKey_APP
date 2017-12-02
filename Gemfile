source 'https://rubygems.org'
ruby '2.4.2'

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
gem 'multi_json'
gem 'roar'

# Services
gem 'dry-monads'
gem 'dry-transaction'

group :test do
  gem 'minitest'
  gem 'minitest-rg'
  gem 'rack-test'

  gem 'chromedriver-helper', '~> 1.0'
  gem 'headless'
  gem 'page-object'
  gem 'watir'
end

group :development do
  gem 'rerun'

  gem 'flog'
  gem 'reek'
  gem 'rubocop'
end

# bundle install --without production
group :production do
  gem 'pg'
end
