class User < ActiveRecord::Base
	has_secure_password
	has_many :farms
	has_many :vegetables, through: :farms
	
	validates :username, presence: true, uniqueness: { case_sensitive: false }
	validates :email, presence: true, uniqueness: { case_sensitive: false }
	validates :password, presence: true
	
	def slug
  	self.username.downcase.gsub(" ", "-").gsub("'", "")
  end
  
  def self.find_by_slug(slug)
    User.find { |user| user.slug == slug }
  end
  
  def this_months_vegetables
    this_month = Time.now.month
    
    self.vegetables.select do |vegetable|
      vegetable.planting_months_as_numbers.include?(this_month)
    end.uniq
  end
end