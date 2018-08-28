class Vegetable < ActiveRecord::Base
	has_and_belongs_to_many :farms
	
	def planting_season
  	months = {}
  	
  	months_to_integers(self[:planting_season]).each do |month|
    	months[month] = Date::MONTHNAMES[month]
    end
    
    months
  end
	
	def user
  	self.farms.first.user
  end
  
  def planting_months_as_names
    planting_season.select.with_index do |month, index|
      month if self.planting_months_as_numbers.include?(index)
    end
  end
	
	private
	
	def months_to_integers(data_saved_from_form)
  	data_saved_from_form.split(" ").collect { |month| month.to_i }
  end
  
end