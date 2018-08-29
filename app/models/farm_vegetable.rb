class FarmVegetable < ActiveRecord::Base
  belongs_to :farm
  belongs_to :vegetable
end