# Adds the author attribute to the database

class AddAuthorToArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :author, :string
  end
end
