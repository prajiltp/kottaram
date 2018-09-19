class UserSubscription < ApplicationRecord
  belongs_to :subscription
  belongs_to :user
  scope :applicable_subscriptions, -> (date_time) {
    where('(active=true OR (deactivated_at <= ? AND created_at >= ?)) AND
      created_at >= ?',
      date_time.end_of_month, date_time.beginning_of_month,
      date_time.beginning_of_month).distinct
  }
  before_create :set_joined_at

  private

  def set_joined_at
  	self.created_at = Time.now.utc
  end
end
