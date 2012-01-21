class User < ActiveRecord::Base

  attr_accessible :name, :email, :password, :password_confirmation

  has_secure_password
  has_many :fillups

  validates_format_of :email, :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/, :on => :create
  validates_length_of :password, :within => 4..20, 
    :too_short => "password must be at least 4 characters", 
    :too_long => "password cannot be longer than 20 characters"
  validates_presence_of :password, :on => :create

end



# == Schema Information
#
# Table name: users
#
#  id              :integer         not null, primary key
#  email           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  password_digest :string(255)
#

