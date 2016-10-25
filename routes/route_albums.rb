
require './lib/net-stuff'

class App < Sinatra::Base
  include NetStuff

  get '/albums/?' do
    haml :form_album_search, locals: {page_title: 'Albums'}
  end

  get '/album/id/:id' do
    query = "albums/tracks/?id=#{params[:id]}&imagesize=200"
    result = fetch(query)
    haml :album, locals: {
      headers: result[:headers],
      artist: {
        id: result[:results].first[:artist_id],
        name: result[:results].first[:artist_name],
      },
      album: {
        id: result[:results].first[:id],
        name: result[:results].first[:name],
        image: result[:results].first[:image],
        zip: result[:results].first[:zip],
        date: result[:results].first[:realeasedate]
      },
      tracks: result[:results].first[:tracks]
    }
  end

  post '/albums' do
    name = params[:name].to_s.scan(Word).join('+')
    sort_by = params[:sort_by]
    query = "albums/tracks?namesearch=#{name}&order=#{sort_by}&imagesize=25"
    result = fetch(query)
    haml :albums_found, locals: {
      page_title: 'Albums',
      headers: result[:headers],
      results: result[:results],
      query: query
      }
  end

end
