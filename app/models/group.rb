class Group < ApplicationRecord
  belongs_to :event
  has_many :user_groups
  has_many :users, through: :user_groups
  scope :vacant, -> (event) { joins(:user_groups).group('groups.id').
  	having('count(user_groups) < ?', event.max_no_of_user_per_group)}
end
