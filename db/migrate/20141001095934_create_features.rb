class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.integer :vehicle_id
      t.string :title

      t.timestamps
    end
  end
end
