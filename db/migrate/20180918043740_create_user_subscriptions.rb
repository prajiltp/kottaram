class CreateUserSubscriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :user_subscriptions do |t|
      t.references :user
      t.references :subscription
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
