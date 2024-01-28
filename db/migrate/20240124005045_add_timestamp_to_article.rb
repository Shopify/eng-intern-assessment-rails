class AddTimestampToArticle < ActiveRecord::Migration[7.1]
  def change
    add_timestamps(:articles)
  end
end
