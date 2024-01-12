class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.string :author, null: false, default: 'Anonymous'
      t.date :date

      t.timestamps
    end
  end
end
