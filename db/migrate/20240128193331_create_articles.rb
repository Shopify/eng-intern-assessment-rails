class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.text :content
      t.string :author
      t.date :date
      t.string :title

      t.timestamps
    end
  end
end
