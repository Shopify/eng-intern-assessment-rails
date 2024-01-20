# frozen_string_literal: true

class AddDateToArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :date, :date
  end
end
