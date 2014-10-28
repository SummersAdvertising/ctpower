class AddDescriptionToVehicles < ActiveRecord::Migration
  def change
    add_column :vehicles, :description, :string
  end
end
