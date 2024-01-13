class Defaultdate < ActiveRecord::Migration[7.1]
  def change
    change_column_default :articles, :date, Time.zone.now
    
  end
end
