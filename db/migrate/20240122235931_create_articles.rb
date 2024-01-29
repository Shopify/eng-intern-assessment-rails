class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :author
      t.string :content
      t.date :date

      t.timestamps
    end
  end
end
