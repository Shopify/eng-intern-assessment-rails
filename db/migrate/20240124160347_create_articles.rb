# This migration file creates the 'articles' table in the database
class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    # Define the table and the columns
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.string :author
      t.date :date

      t.timestamps
    end
  end
end
