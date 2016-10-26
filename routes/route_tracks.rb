require './lib/net-stuff'
require './lib/common'
require 'byebug'

class App < Sinatra::Base
  include NetStuff
  include Common

  attr_accessor :query
  attr_accessor :offset

  get '/tracks' do
    haml :form_track_search, locals: {page_title: 'Tracks'}
  end

  post '/tracks' do
    settings.query = "tracks/?"
    settings.offset = 0
    sort_by = params[:sort_by]
    if params[:'search-by'] == 'Genre'
      name = params[:name].to_s.scan(Word).join('+')
      settings.query += "namesearch=#{name}&boost=#{sort_by}"
    else
      name = params[:name].to_s.scan(Word).join('+')
      if params[:is_fuzzy]
        settings.query += "fuzzysearch=#{name}&boost=#{sort_by}"
      else
        settings.query += "tags=#{name}&order=#{sort_by}"
      end
    end
    settings.query += "&include=musicinfo&groupby=artist_id&imagesize=25&limit=#{settings.page_size}"

    result = fetch("#{settings.query}&offset=#{settings.offset}")
    haml :tracks_found, locals: {
      page_title: 'tracks',
      headers: result[:headers],
      results: result[:results],
      offset: settings.offset
      }
  end

  post '/tracks/next/:direction' do
    mydir = params[:direction].to_sym
    offset_old = settings.offset
    settings.offset = getOffset(mydir, settings.offset, settings.page_size)
    result = fetch("#{settings.query}&offset=#{settings.offset}")
    logger.debug "headers: #{result[:headers]}"
    if result[:headers][:status] == 'success'
      haml :"_tracks",  locals: {
        headers: result[:headers],
        results: result[:results],
        offset: settings.offset
        },
        layout: false
    else
      result = fetch("#{settings.query}&offset=#{offset_old}")
      if result[:headers][:status] == 'success'
        haml :"_tracks",  locals: {
          headers: result[:headers],
          results: result[:results],
          offset: offset_old
          },
          layout: false
      else
        "error"
      end
    end
  end

end
