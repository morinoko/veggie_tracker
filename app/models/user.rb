class User < ActiveRecord::Base
	has_secure_password
	has_many :farms
	has_many :vegetables, through: :farms
	
	validates :username, :email, :password, presence: true
	validates :email, uniqueness: true
end