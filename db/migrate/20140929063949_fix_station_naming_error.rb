class FixStationNamingError < ActiveRecord::Migration
  def change
    rename_column :stations, :adderss, :address
  end
end
