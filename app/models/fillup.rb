class Fillup < ActiveRecord::Base

  after_initialize :default_values

  validates_presence_of :date, :gallons, :miles
  validates_numericality_of [:price_per_gallon, :price, :gallons, :miles], :allow_nil => true

  belongs_to :user

private

  def default_values
    self.date ||= Time.new
  end

end

# TODO: drop price_per_gallon

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

