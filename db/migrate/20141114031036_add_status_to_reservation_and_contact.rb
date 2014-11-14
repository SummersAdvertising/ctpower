class AddStatusToReservationAndContact < ActiveRecord::Migration
  def change
    add_column :contacts, :status, :string, default: 'new'
    add_column :reservations, :status, :string, default: 'new'
  end
end
