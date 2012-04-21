class UploadError < ActiveRecord::Base
end

# == Schema Information
#
# Table name: upload_errors
#
#  id         :integer         not null, primary key
#  user_id    :integer
#  record     :string(255)
#  reason     :string(255)
#  created_at :datetime
#  updated_at :datetime
#

