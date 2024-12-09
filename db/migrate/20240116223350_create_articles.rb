class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    return if table_exists? :articles
  
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.string :author
      t.date :date
  
      t.timestamps
    end
  end
end
