class User < ActiveRecord::Base
	has_secure_password
	has_many :farms
	has_many :vegetables, through: :farms
end