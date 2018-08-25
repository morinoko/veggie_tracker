class CreateFarmsVegetables < ActiveRecord::Migration[5.2]
  def change
    create_table :farms_vegetables, id: false do |t|
      t.belongs_to :farm
      t.belongs_to :vegetable
    end
  end
end
