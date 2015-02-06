class AddIndexToFaq < ActiveRecord::Migration
  def change
    add_index :faqs, :question, :length => { :question => 5 }
  end
end
