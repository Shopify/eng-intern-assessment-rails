#adding in date column to articles table
class AddDateToArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :date, :datetime
  end
end
