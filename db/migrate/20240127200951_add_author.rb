class AddAuthor < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :author, :string
  end
end
