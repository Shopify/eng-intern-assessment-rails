# frozen_string_literal: true

# Migration to create the 'authors' table.
class CreateAuthors < ActiveRecord::Migration[7.1]
  def change
    create_table :authors do |t|
      t.string :name, limit: 64

      t.timestamps
    end
  end
end
