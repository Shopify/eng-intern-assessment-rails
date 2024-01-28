
# database level restriction on the columns.
class ChangeArticleColumnsNull < ActiveRecord::Migration[7.1]
  def change
    change_column_null(:articles, :title, false)
    change_column_null(:articles, :author, false)
    change_column_null(:articles, :content, false)
    change_column_null(:articles, :date, false)
  end
end
