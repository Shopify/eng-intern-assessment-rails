class AddArticleNullConstraints < ActiveRecord::Migration[7.1]
  def change
    # add not null constraints
    change_column_null(:articles, :title, false)
    change_column_null(:articles, :content, false)
    change_column_null(:articles, :date, false)
    change_column_null(:articles, :author, false)
  end
end
