class CreateColors < ActiveRecord::Migration
  def change
    create_table :colors do |t|
      t.integer :vehicle_id
      t.string :hexcode

      t.timestamps
    end
  end
end
