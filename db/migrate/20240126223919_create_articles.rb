class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.string :content, null: false
      t.string :author
      t.datetime :date

      t.timestamps
    end
  end
end
