# run pry -r <path/to/this/file>
require './init.rb'
require 'rack/test'

include Rack::Test::Methods

def app
  WiKey::App
end