class AddUserToFillups < ActiveRecord::Migration
  def change
    add_column :fillups, :user_id, :integer
  end
end
