require 'spec_helper'
require 'common'
include Common

class TestHelper;end

describe Common, focus: true do
  context '#parse_integer' do
    it 'should throw error on non integer-able object' do
      bogus = TestHelper.new
      expect{ parse_integer(bogus) }.to raise_error(ArgumentError)
    end
    it 'should be 100' do
      expect( parse_integer('100') ).to eq(100)
    end
  end
  context '#parse_date' do
    it 'should throw argumentError' do
      expect{ parse_date('XXX') }.to raise_error(ArgumentError)
    end
    it 'should parse a date string' do
      expected = Date.new(2009,10,12)
      expect( parse_date('2009-10-12') ).to eq(expected)
    end
    it 'should accept date object' do
      expected = Date.new(2009,10,12)
      expect( parse_date(expected) ).to eq(expected)
    end
  end
end
