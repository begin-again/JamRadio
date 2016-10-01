
require 'date'
require 'common'

module Radio

  ##
  # == Artist
  class Artist
    include Common

    attr_accessor :website  # artist website url
    attr_accessor :image    # artist image url
    attr_accessor :short    # jamendo short url

    attr_reader :name     # Artist Name
    attr_reader :joined   # date first listed on jamendo YYYY-MM-DD
    attr_reader :id       # Jamendo artist identifier( Integer )

    def initialize
      @albums = Array.new # Album Objects
    end

    ##
    # Sets the artist identifier
    # expects integer
    # throws Argument Error
    def id= n
      @id = parse_integer(n)
    end

    ##
    # Sets artist name
    # expects string
    def name= n
      @name = n.to_s
    end

    ##
    # Sets the jamendo join date
    # Expects Date object of date string
    # Throws Argument Error
    def joined= d
      @joined = parse_date(d)
    end
  end

end
