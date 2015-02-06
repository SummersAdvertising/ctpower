class AddIndexToFaq < ActiveRecord::Migration
  def change
    add_index :faqs, :question
  end
end
