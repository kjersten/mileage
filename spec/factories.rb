require 'date'

@@start = Date.new(2008, 01, 01)

FactoryGirl.define do 

	factory :fillup do
    price_per_gallon 2.984
    gallons 9.50
    price {price_per_gallon * gallons}
    sequence :miles do |n| 
      n * 300 
    end
    sequence :date do |n| 
      @@start + 7 * n 
    end
	end

  factory :user do
    ignore do
      first false
    end

    sequence :name do |n| 
      "Test User#{n unless first}"
    end
    sequence :email do |n| 
      "test#{n unless first}@test.com" 
    end
    password "test"
    password_confirmation "test"
  end
	
end