class Farm < ActiveRecord::Base
	belongs_to :user
	has_and_belongs_to_many :vegetables
	validates :name, :location, presence: true
	
	def slug
  	name.downcase.gsub(" ", "-").gsub("'", "")
  end
end