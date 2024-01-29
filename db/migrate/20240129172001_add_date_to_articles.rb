# Adds the date attribute to the database

class AddDateToArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :date, :date
  end
end
