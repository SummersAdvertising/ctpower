class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.integer :category_id
      t.string :name
      t.text :cf
      t.integer :price
      t.integer :price_for_sale
      t.string :status

      t.timestamps
    end
  end
end
