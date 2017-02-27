class Event < ApplicationRecord
  has_many :groups
  has_many :user_groups, through: :groups
  has_many :users, through: :user_groups

  def assign_user_to_group(user)
  	errors = []
  	if user.part_of_event?(self)
  	  errors << "You are already part of this event"
  	else
  	  begin
        @group = groups.vacant(self).order("RANDOM()").first
      end while @group.users.size >= max_no_of_user_per_group
      @group.user_groups.create(user_id: user.id)
  	end
  	[@group, errors]
  end
end
