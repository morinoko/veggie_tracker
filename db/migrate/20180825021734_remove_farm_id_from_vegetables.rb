class RemoveFarmIdFromVegetables < ActiveRecord::Migration[5.2]
  def change
    remove_column :vegetables, :farm_id, :integer
  end
end
