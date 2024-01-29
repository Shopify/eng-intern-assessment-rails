class ArticlesChange < ActiveRecord::Migration[7.1]
  change_column :articles, :date, :datetime
end
