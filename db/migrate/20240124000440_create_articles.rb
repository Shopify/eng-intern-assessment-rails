class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |table|
      table.string :title
      table.text :content
      table.datetime :date
      table.string :author
    end
  end
end
