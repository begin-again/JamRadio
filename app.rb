
class App < Sinatra::Base
  ENV['TZ'] = 'UTC'

  configure do
    set :root, File.dirname(__FILE__) # You must set app root
    set :cache_enabled, false
    set :sessions, false
    set :show_exceptions, true
    # set :pub, root + '/public'
    set :environment, :development
    set :haml, layout: :layout

    register Sinatra::Partial
    set :partial_template_engine, :haml
    enable :partial_underscores

    register Sinatra::AssetPack
    register Sinatra::Reloader
  end

  assets {
    serve '/js',     from: 'assets/js'
    serve '/css',    from: 'assets/css'
    serve '/images', from: 'assets/images'
    css :main, ['/css/reset.css','/css/app.css']
    js  :main, ['/js/app.js']
  }

  configure :production do
    assets {
      css_compression :sass
      js_compression :jsmin
    }
  end

  Dir.glob('./routes/*.rb').each do |route|
    print "Loading Routes: #{route}..."
    begin
      t = require route
      puts t ? "Success!" : "Failed!"
    rescue Exception => e
      puts route "... Failed!"
      puts "Route Error: #{e.message}"
    end
  end

  before do
    headers "Content-Type" => "text/html; charset=utf-8"
    @js = []
  end

  get '/' do
    haml :index, layout: :layout, locals: {page_title: 'Home'}
  end


end # Website
