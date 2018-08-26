class RemoveAnnualPlantingDatesAndAddPlantingSeasonToVegetables < ActiveRecord::Migration[5.2]
  def change
    remove_column :vegetables, :annual_planting_start_date, :text
    remove_column :vegetables, :annual_planting_end_date, :text
    remove_column :vegetables, :planting_season, :text
    
    add_column :vegetables, :planting_season, :text
  end
end
