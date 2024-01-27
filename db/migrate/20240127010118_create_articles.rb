# frozen_string_literal: true

# Migration to create the 'articles' table with relevant fields in the database.
class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.string :author
      t.date :date

      t.timestamps
    end
  end
end
