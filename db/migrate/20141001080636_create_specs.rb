class CreateSpecs < ActiveRecord::Migration
  def change
    create_table :specs do |t|
      t.integer :vehicle_id
      t.string :title
      t.string :context

      t.timestamps
    end
  end
end
