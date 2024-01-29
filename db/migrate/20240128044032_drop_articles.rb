class DropArticles < ActiveRecord::Migration[7.1]
  def up
    drop_table :articles
  end

  def down
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.string :author
      t.date :date

      t.timestamps
    end
  end
end
