# bin/rails generate migration AddDate
class AddDate < ActiveRecord::Migration[7.1]
  def change
    add_column :articles, :date, :date
  end
end
