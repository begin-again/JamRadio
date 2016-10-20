
require './lib/net-stuff'

class App < Sinatra::Base
  include NetStuff

  get '/artists/?' do
    haml :form_artist_search, locals: {page_title: 'Artists'}
  end

  post '/artists' do
    # puts params[:name].to_s.scan(Word)
    name = params[:name].to_s.scan(Word).join('+')
    sort_by = params[:sort_by]
    query = "artists?namesearch=#{name}&order=#{sort_by}&limit=20"
    query += "&hasimage=true" if params[:image_only] == 'on'
    result = fetch(query)
    haml :artists_found, locals: {
      page_title: 'artists',
      headers: result[:headers],
      artists: result[:results],
      query: query
      }
  end

  get '/artist/id/:id' do
    query = "artists/albums/?id=#{params[:id]}&imagesize=50"
    result = fetch(query)
    haml :artist, locals: {
      headers: result[:headers],
      artist: {
        id: result[:results].first[:id],
        name: result[:results].first[:name],
        website: result[:results].first[:website],
        image: result[:results].first[:image],
        joindate: result[:results].first[:joindate]
      },
      albums: result[:results].first[:albums],
      page_title: "Artist - #{result[:results].first[:name]}"
    }
  end

end
