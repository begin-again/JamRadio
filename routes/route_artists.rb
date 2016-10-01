
require './lib/net-stuff'
require 'byebug'

class App < Sinatra::Base
  include NetStuff

  get '/artists/?' do
    haml :artists, locals: {page_title: 'Artists'}
  end

  post '/artists' do
    puts params[:name].to_s.scan(Word)
    name = params[:name].to_s.scan(Word).join('+')
    sort_by = params[:sort_by]
    query = "artists?namesearch=#{name}&order=#{sort_by}&limit=20"
    query += "&hasimage=true" if params[:image_only] == 'on'
    result = fetch(query)
    haml :artists_result, locals: {
      page_title: 'artists',
      headers: result[:headers],
      results: result[:results],
      query: query
      }
  end

  get '/artist/id/:id' do
    query = "artists/albums/?id=#{params[:id]}&order=name_asc&imagesize=100"
    result = fetch(query)
    haml :albums_result, locals: {
      page_title: "Albums - #{result[:results].first[:name]}",
      headers: result[:headers],
      results: result[:results].first[:albums],
      query: query
      }

  end
end
