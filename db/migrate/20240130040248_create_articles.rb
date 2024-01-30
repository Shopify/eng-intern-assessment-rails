class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title
      t.text :content
      t.string :author
      t.date :date

      t.timestamps
    end
  end
end
