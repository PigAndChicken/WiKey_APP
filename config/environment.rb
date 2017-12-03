require 'roda'
require 'econfig'

module WiKey

  class App < Roda
    plugin :environments
    
    extend Econfig::Shortcut
    Econfig.env = environment.to_s
    Econfig.root = '.'
    
  end
end