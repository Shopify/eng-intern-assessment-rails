# Migration to create the articles table
# This class is inherited from ActiveRecord::Migration[7.1] which is Rails' way of handling database schema changes
class CreateArticles < ActiveRecord::Migration[7.1]
  # The change method tells Rails what change to make to the database
  def change
    # create_table is a method that creates a new table in the database
    create_table :articles do |t|
      # t.string :title creates a new column in the table called title that holds strings
      t.string :title
      # t.text :content creates a new column in the table called content that holds text
      t.text :content
      # t.string :author creates a new column in the table called author that holds strings
      t.string :author
      # t.date :date creates a new column in the table called date that holds date objects
      t.date :date

      # t.timestamps is a shortcut method that creates two new columns in the table called created_at and updated_at
      # These columns are automatically managed by Rails and hold timestamps
      t.timestamps
    end
  end
end