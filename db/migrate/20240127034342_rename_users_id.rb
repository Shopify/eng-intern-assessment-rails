class RenameUsersId < ActiveRecord::Migration[7.1]
  def change
    rename_column :articles, :users_id, :user_id
  end
end
