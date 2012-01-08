class CreateFillups < ActiveRecord::Migration
  def change
    create_table :fillups do |t|
      t.date :date
      t.float :price_per_gallon
      t.float :price
      t.float :gallons
      t.integer :miles
      t.string :note

      t.timestamps
    end
  end
end
