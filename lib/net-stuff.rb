
require 'net/http'
require 'openssl'
require 'json'
require 'byebug'

##
# Network Methods
module NetStuff


  # Jamendo API Client ID
  ClientID = '56d30c95'

  # Jamendo root
  Base = 'https://api.jamendo.com/v3.0/'

  # Regex
  Word = /([^\(\s]\S*)/

  ##
  # Submits GET request to Jamendo +Base+
  # * Accepts string of relevant API
  # * returns JSON

  def fetch url

    response = nil
    begin
      puts "Request Url: #{Base}#{url}&client_id=#{ClientID}&format=json"
      uri = URI.parse("#{Base}#{url}&client_id=#{ClientID}&format=json")
      if uri.host
        Net::HTTP.start(uri.host, uri.port,
          use_ssl: uri.scheme == 'https', verify_mode: OpenSSL::SSL::VERIFY_NONE) do |http|
          request = Net::HTTP::Get.new uri
          response = http.request request # Net::HTTPResponse object
        end
        result = JSON.parse(response.body, symbolize_names: true)
        puts result
        result
      else
        {headers: { status: 'error',error_message: "Bad Url: #{uri}", result_count: 0}}
      end
    rescue Exception => e
     {headers: { status: 'error',error_message: "#{e.message}", result_count: 0}}
    end
  end

end
