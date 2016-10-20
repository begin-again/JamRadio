require './lib/net-stuff'

class App < Sinatra::Base
  include NetStuff

  get '/tracks/?' do
    haml :form_track_search, locals: {page_title: 'Tracks'}
  end

  post '/tracks' do
    query = "tracks/?"
    sort_by = params[:sort_by]
    if params[:'search-by'] == 'Genre'
      name = params[:name].to_s.scan(Word).join('+')
      query += "namesearch=#{name}&boost=#{sort_by}"
    else
      name = params[:name].to_s.scan(Word).join('+')
      if params[:is_fuzzy]
        query += "fuzzysearch=#{name}&boost=#{sort_by}"
      else
        query += "tags=#{name}&order=#{sort_by}"
      end
    end
    query += "&include=musicinfo&groupby=artist_id&imagesize=25&limit=20"

    result = fetch(query)
    haml :tracks_found, locals: {
      page_title: 'tracks',
      headers: result[:headers],
      results: result[:results]
      }
  end
end
