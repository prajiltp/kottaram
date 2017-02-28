class User < ApplicationRecord
  has_many :user_groups
  has_many :groups, through: :user_groups
  has_many :events, through: :groups
  has_many :splitwises, foreign_key: :purchased_by
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :omniauthable, :omniauth_providers => [:google_oauth2]
  validates_uniqueness_of :email

  def self.from_omniauth(auth_info)
  	info = auth_info[:info]
  	@user=User.find_by(email: info[:email])
  	if @user
  	  @user.update(first_name: info[:first_name], last_name: info[:last_name])
  	  @user.save!(validate: false)
  	end
    @user
  end

  def part_of_event?(event)
    events.include? event
  end

  def spent_amount(date_time)
    splitwises.analysis(date_time).cost_of_purchase
  end
end
