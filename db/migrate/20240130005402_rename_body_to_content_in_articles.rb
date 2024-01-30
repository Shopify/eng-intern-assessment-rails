class RenameBodyToContentInArticles < ActiveRecord::Migration[7.1]
  def change
    rename_column :articles, :body, :content

  end
end
