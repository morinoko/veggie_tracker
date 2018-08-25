class User < ActiveRecord::Base
	has_secure_password
	has_many :farms
	has_many :vegetables, through: :farms
	
	validates :username, :email, :password, presence: true
	validates :email, :username, uniqueness: true
	
	def slug
  	self.username.downcase.gsub(" ", "-").gsub("'", "")
  end
  
  def self.find_by_slug(slug)
    User.find { |user| user.slug == slug }
  end
end