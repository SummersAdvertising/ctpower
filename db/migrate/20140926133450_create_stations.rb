class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.string :name
      t.text :intro
      t.string :phone
      t.string :adderss
      t.integer :country
      t.integer :city
      t.integer :district
      t.text :ophour
      t.text :latlng

      t.timestamps
    end
  end
end
