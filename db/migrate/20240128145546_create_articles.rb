# Creates a database table for managing articles with the following columns
class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.text :author
      t.date :date
      
      t.timestamps
    end
  end
end

