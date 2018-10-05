class AddRealtorToHouses < ActiveRecord::Migration[5.1]
  def change
    add_reference :houses, :realtor, index: true
  end
end
