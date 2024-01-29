class AddDateToArticle < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :date, :Date
  end
end
