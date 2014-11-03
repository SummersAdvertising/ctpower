class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :subject
      t.string :name
      t.string :email
      t.string :phone
      t.string :content

      t.timestamps
    end
  end
end
