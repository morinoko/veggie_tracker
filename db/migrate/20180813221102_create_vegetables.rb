class CreateVegetables < ActiveRecord::Migration[5.2]
  def change
	  create_table :vegetables do |t|
		  t.string :name
		  t.text :planting_season
		end
  end
end
