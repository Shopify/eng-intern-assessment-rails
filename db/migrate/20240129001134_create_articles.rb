class CreateArticles < ActiveRecord::Migration[7.1]
  # Migration for creating an articles table
  # Includes an article title, text, and timestamps
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
