class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.integer :max_no_of_user_per_group
      t.integer :max_nof_groups
      t.timestamps
    end
    add_index :users, :email,                unique: true
  end
end
