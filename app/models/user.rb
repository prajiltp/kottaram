class User < ApplicationRecord
  has_many :user_groups
  has_many :groups, through: :user_groups
  has_many :events, through: :groups
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
end
