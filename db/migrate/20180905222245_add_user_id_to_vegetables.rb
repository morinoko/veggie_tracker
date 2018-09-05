class AddUserIdToVegetables < ActiveRecord::Migration[5.2]
  def change
    add_column :vegetables, :user_id, :integer
  end
end
