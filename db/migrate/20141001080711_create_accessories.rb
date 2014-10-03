class CreateAccessories < ActiveRecord::Migration
  def change
    create_table :accessories do |t|
      t.integer :vehicle_id
      t.string :title
      t.text :context
      t.string :type

      t.timestamps
    end
  end
end
