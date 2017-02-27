class Splitwise < ApplicationRecord
  belongs_to :creator, class_name: :User, foreign_key: :created_by
  belongs_to :purchasee, class_name: :User, foreign_key: :purchased_by

  scope :monthly_purchase, -> (date) {where(purchased_at: [date.beginning_of_month, date.end_of_month])}
end
