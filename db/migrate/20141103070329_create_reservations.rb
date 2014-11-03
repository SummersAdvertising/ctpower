class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.string :subject
      t.string :name
      t.string :email
      t.string :phone
      t.string :content

      t.timestamps
    end
  end
end
