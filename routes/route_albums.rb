
require './lib/net-stuff'

class App < Sinatra::Base
  include NetStuff

  get '/albums/?' do 
    haml :albums, locals: {page_title: 'Albums'}
  end

  get '/album/id/:id' do 
    query = "albums/tracks/?id=#{params[:id]}"
    result = fetch(query)
    haml :album_tracks, locals: {
      page_title: 'Tracks', 
      headers: result[:headers], 
      results: result[:results], 
      query: query
      }

  end

  post '/albums' do 
    name = params[:name].to_s.scan(Word).join('+')
    query = "albums/tracks?namesearch=#{name}&imagesize=150"
    result = fetch(query)
    haml :albums_result, locals: {
      page_title: 'Albums', 
      headers: result[:headers], 
      results: result[:results], 
      query: query
      }
  end

end