class Vegetable < ActiveRecord::Base
  has_many :farm_vegetables
	has_many :farms, through: :farm_vegetables
	
	def planting_season
  	months = {}
  	
  	months_to_integers(self[:planting_season]).each do |month|
    	months[month] = localized_months[month]
    end
    
    months
  end
	
	def user
  	self.farms.first.user
  end
  
  def planting_season_month_names
    planting_season.values
  end
	
	private
	
	def months_to_integers(data_saved_from_form)
  	data_saved_from_form.split(" ").collect { |month| month.to_i }
  end
  
  def localized_months
    I18n.t('date.month_names')
  end
end