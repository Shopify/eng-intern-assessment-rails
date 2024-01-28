class Delstringfield < ActiveRecord::Migration[7.1]
  def self.up
    remove_column :Articles,:string
  end
end
