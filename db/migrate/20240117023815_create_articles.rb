class CreateArticles < ActiveRecord::Migration[7.1]
  def up
    drop_table :articles
  end

  def change
    create_table :articles do |t|
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
