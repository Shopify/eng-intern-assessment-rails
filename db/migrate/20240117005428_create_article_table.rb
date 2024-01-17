class CreateArticleTable < ActiveRecord::Migration[7.1]
  def change
    create_table :article_tables do |t|
      t.string :title
      t.string :author
      t.text :content
      t.date :created_date

      t.timestamps
    end
  end
end
