class CreateWriters < ActiveRecord::Migration[7.1]
  def change
    create_table :writers do |t|
      t.string :name

      t.timestamps
    end
  end
end
