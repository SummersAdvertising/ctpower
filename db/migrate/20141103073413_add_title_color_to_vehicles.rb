class AddTitleColorToVehicles < ActiveRecord::Migration
  def change
    add_column :vehicles, :title_color, :string
  end
end
