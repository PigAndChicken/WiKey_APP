require 'roda'
require 'econfig'

module WiKey
  # configuration for the App
  class App < Roda
    plugin :environments
    
    extend Econfig::Shortcut
    Econfig.env = environment.to_s
    Econfig.root = '.'
  end
end