require './lib/net-stuff'
require 'byebug'

class App < Sinatra::Base
  include NetStuff

  def getOffset direction, offset
    o = offset.to_i
    o = 0 if o < 0
    if direction == :forward
      o += 10
    else
      if (o - 10) < 0
        o = 0
      else
        o -= 10
      end
    end
  end

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
    query += "&include=musicinfo&groupby=artist_id&imagesize=25&limit=10"

    result = fetch(query)
    haml :tracks_found, locals: {
      page_title: 'tracks',
      headers: result[:headers],
      results: result[:results],
      forward: getOffset(:forward, 0),
      backward: getOffset(:backward, 0),
      query: query
      }
  end

  post '/tracks/offset' do
    offset = params[:offset].to_i || 0
    query = params[:query]
    result = fetch("#{query}&offset=#{offset}")

    begin
      haml :"_tracks",  locals: {
        page_title: 'album',
        headers: result[:headers],
        results: result[:results],

        forward: getOffset(:forward, offset),
        backward: getOffset(:backward, offset),
        query: query
        }, layout: false
    rescue Exception => e
      "<h2>#{e.name}</h2>"
    end
  end

end
