class AddIdAndDateToArticles < ActiveRecord::Migration[7.1]
  def change
    change_column :articles, :created_at, :datetime
    change_column :articles, :updated_at, :datetime
  end
end
