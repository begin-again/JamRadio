
require 'spec_helper'
require 'artist'

class TestHelper;end

describe Radio::Artist do
  before :each do
    @artist = Radio::Artist.new
  end
  context '#name' do
    it 'should have a name attribute' do
      expect( @artist ).to respond_to(:name)
    end
    it 'should be nil on init' do
      expect( @artist.name ).to be_nil
    end
    it 'should be hello' do
      @artist.name = 'hello'
      expect( @artist.name ).to eq('hello')
    end
    it 'should be empty string' do
      @artist.name = nil
      expect( @artist.name ).to be_empty
    end
  end
  context '#id' do
    it 'should have an id attribute' do
      expect( @artist ).to respond_to(:id)
    end
    it 'should throw error on non integer-like objects' do
      bogus = TestHelper.new
      expect{ @artist.id = bogus}.to raise_error(ArgumentError)
    end
    it 'should be 100' do
      @artist.id = '100'
      expect( @artist.id ).to eq(100)
    end
  end
  context '#joined' do
    it 'should have joined attribute' do
      expect( @artist ).to respond_to(:joined)
    end
    it 'should throw argumentError' do
      bogus = 'XXX'
      expect{ @artist.joined = bogus }.to raise_error(ArgumentError)
    end
    it 'should parse a date string' do
      expected = Date.new(2009,10,12)
      @artist.joined = '2009-10-12'
      expect( @artist.joined ).to eq(expected)
    end
    it 'should accept date object' do
      expected = Date.new(2009,10,12)
      @artist.joined = expected
      expect( @artist.joined ).to eq(expected)
    end
  end
  context '#website' do
  end
  context '#image' do
  end
  context '#short' do
  end
end
