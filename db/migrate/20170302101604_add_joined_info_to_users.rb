class AddJoinedInfoToUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :joined_at, :datetime
  	# For existing user
  	User.all.each do |user|
  	  user.joined_at = Time.new(2017,2,1,0,0).utc
  	  user.save
  	end
  end
end
