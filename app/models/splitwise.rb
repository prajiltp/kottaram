class Splitwise < ApplicationRecord
  belongs_to :creator, class_name: :User, foreign_key: :created_by
  belongs_to :purchasee, class_name: :User, foreign_key: :purchased_by
  belongs_to :subscription
  before_validation :convert_to_utc

  validates :price, presence: true
  validate :purchased_month
  before_destroy :purchased_month_valid?

  scope :monthly_purchase, -> (date) {where('purchased_at >=? and purchased_at <= ?',
    date.beginning_of_month, date.end_of_month)}

  class << self
    def analysis(date_time)
      monthly_purchase = monthly_purchase(date_time).order('purchased_at DESC')
    end

    def total_expense(date_time)
      cost = cost_of_purchase
      total_penalty = Penalty.billable_penalty_amount(date_time)
      rent = HouseInfo.rent_for(date_time)
      total_expense = cost + rent - total_penalty
    end

    def cost_of_purchase
      sum(&:price).to_f
    end

    def other_expense(date_time)
      monthly_purchase(date_time).where('subscription_id IS NULL = ?', true).sum(&:price)
    end
  end

  def purchased_month_valid?
    purchased_month
    unless self.errors.blank?
      false
      throw(:abort)
    end
  end

  private

  def convert_to_utc
    self.purchased_at = Time.parse("#{self.purchased_at}").utc.iso8601 if purchased_at
  end

  def purchased_month
    if Time.now.utc.month > purchased_at.month
      self.errors.add(:purchased_at, 'You can not add or update a bill on previous month')
    end
  end
end
