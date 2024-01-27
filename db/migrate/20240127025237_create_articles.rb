class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.references :users, null: false, foreign_key: true

      t.timestamps
    end
  end
end
