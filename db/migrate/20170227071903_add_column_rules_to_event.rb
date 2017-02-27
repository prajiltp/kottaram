class AddColumnRulesToEvent < ActiveRecord::Migration[5.0]
  def change
  	add_column :events, :rules, :text
  end
end
