class RemoveTimestampsFromArticles < ActiveRecord::Migration[6.0]
  def change
    remove_column :articles, :created_at, :datetime
    remove_column :articles, :updated_at, :datetime
  end
end
