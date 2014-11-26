class AddMissingIndexes < ActiveRecord::Migration
  def change
    add_index :accessories, [:id, :type]
    add_index :accessories, :vehicle_id
    add_index :announcements, :article_id
    add_index :announcements, [:id, :type]
    add_index :banners, [:id, :type]
    add_index :boxes, :parent_id
    add_index :categories, :parent_id
    add_index :colors, :vehicle_id
    add_index :faqs, :box_id
    add_index :faqs, :article_id
    add_index :features, :vehicle_id
    add_index :galleries, [:attachable_id, :attachable_type]
    add_index :galleries, [:id, :type]
    add_index :photos, :article_id
    add_index :specs, :vehicle_id
    add_index :vehicles, :category_id
  end
end