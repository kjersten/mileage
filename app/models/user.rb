class User < ActiveRecord::Base

  attr_accessible :name, :email, :password, :password_confirmation

  has_secure_password
  has_many :fillups

  validates_format_of :email, :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/, :on => :create, :allow_blank => true
  validates_length_of :password, :on => :create, :within => 4..20, :allow_blank => true,
    :too_short => "must be at least 4 characters", 
    :too_long => "cannot be longer than 20 characters"
  validates_presence_of :name, :email, :password
  validates_uniqueness_of :email

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

