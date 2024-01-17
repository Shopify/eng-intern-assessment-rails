class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :author
      t.text :content
      t.date :created_date
      t.date :updated_date

      t.timestamps
    end
  end
end
