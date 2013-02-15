require 'spec_helper'

describe Fillup do
  
    it "should populate an empty fillup with today's date" do
      fillup = Fillup.new
      fillup.date.strftime('%m/%d/%Y').should == Time.new.strftime('%m/%d/%Y')
    end


end