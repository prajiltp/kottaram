class CreateSplitwises < ActiveRecord::Migration[5.0]
  def change
    create_table :splitwises do |t|
      t.datetime :purchased_at
      t.integer :created_by
      t.integer :purchased_by
      t.float :price
      t.string :item_name
      t.text :description
      t.float :quantity
      t.float :remaining_quantity
      t.timestamps
    end
  end
end
