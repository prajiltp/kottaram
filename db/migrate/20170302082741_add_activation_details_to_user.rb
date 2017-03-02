class AddActivationDetailsToUser < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :active, :boolean, default: :true
  	add_column :users, :de_activated_at, :datetime
  end
end
