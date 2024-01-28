class ChangeArticleAuthorColumnNull < ActiveRecord::Migration[7.1]
  def change
    change_column_null(:articles, :author, true)
  end
end
