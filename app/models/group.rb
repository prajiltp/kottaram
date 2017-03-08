class Group < ApplicationRecord
  include ThreadUtility

  belongs_to :event
  has_many :user_groups
  has_many :users, through: :user_groups
  scope :vacant, -> (event) { joins(:user_groups).group('groups.id').
  	having('count(user_groups) < ?', event.max_no_of_user_per_group)}

  enum slot: %w(day morning evening)
  enum status: %w(done turn_active)

  def complete_and_reassign
    next_group = event.next_group(self)
    next_group.assign_event(self)
    self.done!
    thread do
      event_name = event.cooking? ? 'cooking' : event.name
      subject = "Re-assigned #{event_name} for #{slot} on #{event_date}"
      users.map {|user| EventMailer.changed_event(user, event, subject, 'plus').deliver!}
    end
  end

  def assign_event(current_group)
    if event.cooking?
      self.event_date = event.next_date(current_group) if current_group.evening?
      event.next_slot(current_group, self)
    else
      self.event_date = event.next_date(current_group)
    end
    self.turn_active!
  end

  def skip_for_slot
    if event.cooking?
      event.move_to_next_slot(self)
    else
      self.event_date = event.next_date(self, 1)
      self.save
    end
    thread do
      event_name = event.cooking? ? 'cooking' : event.name
      subject = "Skipped #{event_name} to #{slot} on #{event_date}"
      users.map {|user| EventMailer.changed_event(user, event, subject, 'negative').deliver!}
    end
  end
end
