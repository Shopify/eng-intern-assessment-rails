# frozen_string_literal: true

# Inital migration for articles
class CreateArticles < ActiveRecord::Migration[7.1]
  # Creates a table for holding Article instances with the following columns:
  # - author: string
  # - title: string (required)
  # - content: string (required)
  # - date: date (default value: Date.today)
  def change
    create_table(:articles) do |t|
      t.string(:author)
      t.string(:title, null: false)
      t.string(:content, null: false)
      t.date(:date, default: Time.zone.today)

      t.timestamps
    end
  end
end
