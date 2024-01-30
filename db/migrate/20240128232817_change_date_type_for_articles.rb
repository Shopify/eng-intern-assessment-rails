class ChangeDateTypeForArticles < ActiveRecord::Migration[7.1]
  # Handle date value by changing from string to type date
  def change
    change_column :articles, :date, :date
  end
end
