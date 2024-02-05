class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    #all the necessary attributes for the article model
    create_table :articles do |t|
      t.string :title
      t.string :content
      t.string :author
      t.date :date

      t.timestamps
    end
  end
end
