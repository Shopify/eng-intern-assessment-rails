class AddLikesToArticles < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :claps, :integer, default: 0
  end
end
