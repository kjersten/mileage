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
      pw_reset false
    end

    sequence :name do |n| 
      "Test User#{n}"
    end
    sequence :email do |n| 
      "test#{n}@test.com" 
    end
    password "test"
    password_confirmation "test"
    password_reset_token { pw_reset ? User.generate_token(:password_reset_token) : nil }
    password_reset_sent_at { pw_reset ? Time.zone.now : nil }
  end
	
end