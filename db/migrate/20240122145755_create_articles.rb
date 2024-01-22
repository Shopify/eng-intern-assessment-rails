class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.string :title, limit: 128
      t.text :content, limit: 4096
      t.date :date
      t.references :author, null: false, foreign_key: true

      t.timestamps
    end
  end
end
