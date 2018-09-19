class AddColumnSubscriptionToSplitwise < ActiveRecord::Migration[5.0]
  def change
  	add_column :splitwises, :subscription_id, :integer
  end
end
