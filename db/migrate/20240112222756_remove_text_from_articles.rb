class RemoveTextFromArticles < ActiveRecord::Migration[7.1]
  def change
    remove_column :articles, :text, :string
  end
end
