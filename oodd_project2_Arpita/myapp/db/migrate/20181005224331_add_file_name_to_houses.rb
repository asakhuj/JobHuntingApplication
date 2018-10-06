class AddFileNameToHouses < ActiveRecord::Migration[5.1]
  def change
    add_column :houses, :file_name, :string
  end
end
