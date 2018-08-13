class CreateFarms < ActiveRecord::Migration[5.2]
  def change
	  create_table :farms do |t|
		  t.string :name
		  t.string :location
		  t.integer :user_id
		end
  end
end
