class CreateFaqs < ActiveRecord::Migration
  def change
    create_table :faqs do |t|
      t.integer :box_id
      t.text :question
      t.integer :article_id

      t.timestamps
    end
  end
end
