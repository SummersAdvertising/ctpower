class AddLatLngToStations < ActiveRecord::Migration
  def change
    add_column :stations, :lat, :decimal, {:precision=>10, :scale=>6}
    add_column :stations, :lng, :decimal, {:precision=>10, :scale=>6}
  end
end
