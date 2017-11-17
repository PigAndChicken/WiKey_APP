require 'roda'
require 'slim'

module WiKey
#Web Api
  class App < Roda
    plugin :render, engine: 'slim', views: 'presentation/views'
    plugin :assets, css: 'style.css', path: 'presentation/assets'

    route do |routing|
      routing.assets
      app = App
      
      # GET request
      routing.root do
        view 'home'
      end
    end
  end
end