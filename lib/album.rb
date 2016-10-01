require 'common'

module Radio
  class Album
    include Common

    attr_reader :id         # jamendo album identifier
    attr_reader :artist     # artist identifier
    attr_reader :released   # date released

    attr_accessor :image    # url to image if any
    attr_accessor :name     # albumn name
    attr_accessor :zip      # url to pkzip file
    attr_accessor :short    # url to jamendo page

    def initialize
      @songs = Array.new    # song objects
    end

    def id= n
      @id = parse_integer(n)
    end

    def artist= n
      @artist = parse_integer(n)
    end

    def released= d
      @released = parse_date(d)
    end

  end
end
