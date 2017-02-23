class CreateGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :groups do |t|
      t.string :name
      t.integer :event_id
      t.boolean :active, default: true
      t.timestamps
    end
  end
end
