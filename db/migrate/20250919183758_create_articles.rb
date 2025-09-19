# Migration to create the articles table
#
# This migration creates the articles table with the following columns:
#   - title: string (255 characters max) - The article title
#   - content: text (unlimited length) - The article content
#   - author: string (255 characters max) - The author's name (optional)
#   - date: date - The publication date (optional)
#   - created_at: timestamp - When the record was created
#   - updated_at: timestamp - When the record was last updated
#
# The table supports the Article model with its validations and search functionality.
class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.string :title, null: false, limit: 255
      t.text :content, null: false
      t.string :author, limit: 100
      t.date :date

      t.timestamps
    end

    # Add indexes for better performance
    add_index :articles, :title
    add_index :articles, :author
    add_index :articles, :date
  end
end
