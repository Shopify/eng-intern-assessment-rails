class AddDateToArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :date, :string
  end
end
