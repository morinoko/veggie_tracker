class CreateVegetables < ActiveRecord::Migration[5.2]
  def change
	  create_table :vegetables do |t|
		  t.string :name
		  t.text :annual_planting_start_date
		  t.text :annual_planting_end_date
		  t.integer :farm_id
		end
  end
end
