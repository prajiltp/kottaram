class Subscription < ApplicationRecord
  has_many :user_subscriptions, dependent: :destroy
  has_many :users, through: :user_subscriptions
  has_many :splitwises, dependent: :destroy

  def monthly_cost(date)
    splitwises.monthly_purchase(date).sum(&:price)
  end

  def applicable_user(date_time)
    user_subscriptions.applicable_subscriptions(date_time).distinct
  end
end
