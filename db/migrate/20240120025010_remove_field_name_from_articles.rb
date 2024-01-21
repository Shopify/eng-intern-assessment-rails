class RemoveFieldNameFromArticles < ActiveRecord::Migration[7.1]
  def change
    remove_column :articles, :date, :datetime
  end
end
