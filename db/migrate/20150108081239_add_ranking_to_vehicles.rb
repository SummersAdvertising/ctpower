class AddRankingToVehicles < ActiveRecord::Migration
  def change
    add_column :vehicles, :ranking, :integer, default: 999
    add_column :categories, :ranking, :integer, default: 999
  end
end
