#Adding in the content column to the articles table
class AddContentToArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :content, :text
  end
end
