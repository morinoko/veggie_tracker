class Vegetable < ActiveRecord::Base
  has_many :farm_vegetables
  has_many :farms, through: :farm_vegetables
  belongs_to :user

  def planting_season
    months = {}

    months_to_integers(self[:planting_season]).each do |month|
      months[month] = localized_months[month]
    end

    months
  end

  def planting_season_month_names
    planting_season.values
  end

  def plant_this_month?
    this_month = Time.now.month
    self.planting_season.include?(this_month)
  end

  def self.this_months_vegetables_for(user)
    user.vegetables.select do |vegetable|
      vegetable.plant_this_month?
    end.uniq
  end

  def plant_in_month?(month)
    self.planting_season.include?(month)
  end

  def self.vegetables_for_month(month:, user:)
    user.vegetables.select do |vegetable|
      vegetable.plant_in_month?(month)
    end.uniq
  end

  private

  def months_to_integers(data_saved_from_form)
    data_saved_from_form.split(" ").collect { |month| month.to_i }
  end

  def localized_months
    I18n.t('date.month_names')
  end
end
