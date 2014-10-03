class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.string :title
      t.string :description
      t.integer :related_product_id
      t.integer :ranking, :null => false, :default => 999
      t.integer :status
      t.string :type

      t.timestamps
    end
  end
end
