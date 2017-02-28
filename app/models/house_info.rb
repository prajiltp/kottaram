class HouseInfo < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end
