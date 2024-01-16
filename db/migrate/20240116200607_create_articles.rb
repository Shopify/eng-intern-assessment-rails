class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.string :title # Define table structure to have, title, content, author and date as per tests
      t.text :content
      t.string :author
      t.date :date

      t.timestamps
    end
  end
end
