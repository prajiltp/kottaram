class HouseInfo < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  def self.rent_for(date_time)
     rents = HouseInfo.where('agreement_created <=?', date_time).map {|house| house.rent if (house.agreement_created + house.agreement_validity.months).end_of_month >= date_time}
     (rents.last || 0).to_f
  end
end
