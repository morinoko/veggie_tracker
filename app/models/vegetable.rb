class Vegetable < ActiveRecord::Base
	has_and_belongs_to_many :farms
	
	def planting_months
  	self.planting_season.split(" ").collect { |month| month.to_i }
  end
end