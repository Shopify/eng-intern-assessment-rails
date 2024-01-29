class AddAuthorAndDateToArticles < ActiveRecord::Migration[7.1]
  # Migration to add an author, string and date column for the articles table
  def change
    add_column :articles, :author, :string
    add_column :articles, :date, :date
  end
end
