class AddContextToFeature < ActiveRecord::Migration
  def change
    add_column :features, :context, :string
  end
end
