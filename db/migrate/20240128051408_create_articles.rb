class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.text :title, null: false
      t.text :content, null: false
      t.text :author
      t.datetime :date

      t.timestamps
    end
  end
end
