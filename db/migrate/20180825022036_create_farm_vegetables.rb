class CreateFarmVegetables < ActiveRecord::Migration[5.2]
  def change
    create_table :farm_vegetables do |t|
      t.belongs_to :farm
      t.belongs_to :vegetable
    end
  end
end
