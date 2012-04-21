class User < ActiveRecord::Base

  attr_accessible :name, :email, :password, :password_confirmation

  has_secure_password
  has_many :fillups

  validates_format_of :email, :with => /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/, :on => :create, :allow_blank => true
  validates_length_of :password, :on => :create, :within => 4..20, :allow_blank => true,
    :too_short => "must be at least 4 characters", 
    :too_long => "cannot be longer than 20 characters"
  validates_presence_of :name, :email, :password, :unless => :save_when_sending_password_reset
  validates_uniqueness_of :email

  before_create { generate_token(:auth_token) }

  # password_reset_sent_at happened in the past 2 seconds?
  def save_when_sending_password_reset
    self.respond_to?(:password_reset_sent_at) && password_reset_sent_at && password_reset_sent_at > 2.seconds.ago
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

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
#  name            :string(255)
#  auth_token      :string(255)
#

# == Schema Information
#
# Table name: users
#
#  id                     :integer         not null, primary key
#  email                  :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#  password_digest        :string(255)
#  name                   :string(255)
#  auth_token             :string(255)
#  password_reset_token   :string(255)
#  password_reset_sent_at :datetime
#

