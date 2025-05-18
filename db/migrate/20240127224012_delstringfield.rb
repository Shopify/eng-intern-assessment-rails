class Delstringfield < ActiveRecord::Migration[7.1]
  #Created a method to delete an accidentally created field in the articles table
  def self.up
    remove_column :Articles,:string
  end
end
