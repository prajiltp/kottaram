class AddColumnDeactivatedAtToUserSubscription < ActiveRecord::Migration[5.0]
  def change
  	add_column :user_subscriptions, :deactivated_at, :datetime
  end
end
