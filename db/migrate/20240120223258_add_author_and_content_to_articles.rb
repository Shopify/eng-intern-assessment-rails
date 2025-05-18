class AddAuthorAndContentToArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :author, :string
    add_column :articles, :content, :text
    add_column :articles, :date, :date # note that the date column also added
  end
end
