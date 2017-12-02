require 'roda'

module WiKey
  # configuration for the App
  class App < Roda
    plugin :environments
    
    configure :development do
      # Allows running reload! in pry to restart entire app
      def self.reload!
        exec 'pry -r ./spec/test_load_all'
      end
    end
  end
end
