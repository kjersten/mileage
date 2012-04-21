class CreateUploadErrors < ActiveRecord::Migration
  def change
    create_table :upload_errors do |t|
      t.integer :user_id
      t.string :record
      t.string :reason

      t.timestamps
    end
  end
end
