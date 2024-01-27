class AddAuthorAndDateToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :title, :string
    add_column :articles, :content, :string
    add_column :articles, :author, :string
    add_column :articles, :date, :date
  end
end
