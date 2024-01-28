class AddTitleToArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :title, :string
  end
end
