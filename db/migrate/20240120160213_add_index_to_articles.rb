class AddIndexToArticles < ActiveRecord::Migration[7.1]
  def change
    add_index :articles, :title

  end
end
