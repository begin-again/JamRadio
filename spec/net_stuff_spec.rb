require 'spec_helper'
require 'net-stuff'

include NetStuff

Default = "namesearch=brad"
describe NetStuff do
  it 'should not crash on nil url' do
    expect{ fetch(nil) }.not_to raise_error()
  end
  it 'should not crash on bogus url' do
    expect{ fetch('') }.not_to raise_error()
  end
  it 'should always be a hash with key headers' do
    expect( fetch('albums/?namesearch=munson')  ).to include(:headers)
    expect( fetch(nil)  ).to include(:headers)
    expect( fetch('::::')  ).to include(:headers)
  end
  it 'should have results size = 0' do
    expect( fetch(nil)[:results].size  ).to eq 0
    expect( fetch('12345x')[:results].size  ).to eq 0
  end
  it 'should have results size > 0 ' do
    expect( fetch('albums/?namesearch=munson')[:results].size  ).to be > 0
  end
end
