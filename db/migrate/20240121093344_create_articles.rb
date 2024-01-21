class CreateArticles < ActiveRecord::Migration[7.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.text :content
      t.string :author
      t.datetime :date

      t.timestamps
    end

    add_reference :articles, :image, foreign_key: { to_table: :active_storage_blobs }
  end
end