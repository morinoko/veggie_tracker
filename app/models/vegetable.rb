class Vegetable < ActiveRecord::Base
	has_and_belongs_to_many :farms
	
	def user
  	self.farms.first.user
  end
	
	def planting_months_as_numbers
  	self.planting_season.split(" ").collect { |month| month.to_i }
  end
  
  def planting_months_as_names
    Date::MONTHNAMES.select.with_index do |month, index|
      month if self.planting_months_as_numbers.include?(index)
    end
  end
end