class User < ApplicationRecord
  has_many :user_groups
  has_many :groups, through: :user_groups
  has_many :events, through: :groups
  has_many :splitwises, foreign_key: :purchased_by
  has_many :penalties, foreign_key: :user_id

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,
         :omniauthable, :omniauth_providers => [:google_oauth2]
  validates_uniqueness_of :email

  scope :billable, -> (date_time) { where('(active=true OR de_activated_at >= ?) AND joined_at <= ?',
    date_time.end_of_month, date_time.beginning_of_month)}

  before_create :set_joined_at

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

  def de_activate
    self.active = false
    self.de_activated_at = Time.now.utc
    self.save
    # Remove User from active groups
    self.user_groups.destroy_all
  end

  def part_of?(group)
    group.users.include? self
  end

  def penalty(date_time)
    penalties.monthly_penalty(date_time).sum(&:amount)
  end

  private

  def set_joined_at
    self.joined_at = Time.now.utc
  end
end
