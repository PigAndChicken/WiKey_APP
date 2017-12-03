require 'roda'
require 'slim'
require 'slim/include'

module WiKey
#Web Api
  class App < Roda
    plugin :render, engine: 'slim', views: 'presentation/views'
    plugin :assets, css: 'style.css', path: 'presentation/assets'
    plugin :flash
    plugin :multi_route
    
    use Rack::Session::Cookie, secret: config.SESSION_SECRET
    
    require_relative 'article'
    require_relative 'summaries'
    
    route do |routing|
      routing.assets

      routing.root do
        flash.now[:notice] = "Let's enter a topic to try"
        
        view 'home', locals: { home: true }
      end
      
      routing.on do
        routing.multi_route
      end
      

    end
  end
end