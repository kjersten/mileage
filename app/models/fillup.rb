class Fillup < ActiveRecord::Base

  belongs_to :user

  validates_presence_of :date, :gallons, :miles
  validates_numericality_of [:price_per_gallon, :price, :gallons, :miles], :allow_nil => true

end


# == Schema Information
#
# Table name: fillups
#
#  id               :integer         not null, primary key
#  date             :date
#  price_per_gallon :float
#  price            :float
#  gallons          :float
#  miles            :integer
#  note             :string(255)
#  created_at       :datetime
#  updated_at       :datetime
#  user_id          :integer
#

