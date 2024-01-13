class UpdateField < ActiveRecord::Migration[7.1]
  def change
    rename_column :articles, :name, :author
  end
end
