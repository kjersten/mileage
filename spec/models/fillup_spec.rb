require 'spec_helper'

describe Fillup do
  
  describe '.default_values' do
  	
  	it "should populate an empty fillup with today's date" do
      fillup = Fillup.new
  		fillup.date.strftime('%m/%d/%Y').should == Time.new.strftime('%m/%d/%Y')
  	end
    
    it "should not overwrite the date from an existing fillup" do
      fillup = FactoryGirl.create :fillup
      fillup.date.strftime('%m/%d/%Y').should == '01/08/2008'
  		fillup.date.strftime('%m/%d/%Y').should_not == Time.new.strftime('%m/%d/%Y')
  	end

  end

end
