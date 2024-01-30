class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.string :title, null: false, limit: 255
      t.text :content, null: false
      t.string :author, null: false, limit: 80
      t.date :date, null: false

      t.timestamps
    end
  end
end
