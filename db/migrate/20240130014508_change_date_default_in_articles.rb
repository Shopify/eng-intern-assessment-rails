class ChangeDateDefaultInArticles < ActiveRecord::Migration[7.1]
  def up
    change_column :articles, :date, :datetime, default: -> { 'CURRENT_TIMESTAMP' }
  end

  def down
    change_column :articles, :date, :datetime, default: nil
  end
end
