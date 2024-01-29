class ChangeContentToText < ActiveRecord::Migration[7.1]
  def change
    change_column :articles,
                  :content, :text
  end
end
