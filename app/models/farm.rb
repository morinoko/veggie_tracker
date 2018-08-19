class Farm < ActiveRecord::Base
	belongs_to :user
	has_many :vegetables
	
	def slug
  	name.downcase.gsub(" ", "-").gsub("'", "")
  end
  
  def self.find_by_slug(slug)
    Farm.find { |farm| farm.slug == slug }
  end
end