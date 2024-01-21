class ChangeUserIdToStringInArticles < ActiveRecord::Migration[7.1]
  def change
    change_column :articles, :user_id, :string
  end
end
