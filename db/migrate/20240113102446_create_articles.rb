class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.string :name
      t.string :title
      t.string :content
      t.datetime :date

      t.timestamps
    end
  end
end
