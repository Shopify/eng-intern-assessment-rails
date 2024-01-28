class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :author
      t.text :content
      t.datetime :date, default: -> { "CURRENT_TIMESTAMP" }

      t.timestamps
    end
  end
end
