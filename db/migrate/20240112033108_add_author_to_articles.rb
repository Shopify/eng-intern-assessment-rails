class AddAuthorToArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :author, :text
  end
end
