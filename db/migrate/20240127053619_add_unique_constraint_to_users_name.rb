class AddUniqueConstraintToUsersName < ActiveRecord::Migration[7.1]
  def change
    User.where(name: nil).each do |user|
      user.update(name: "DefaultName_#{user.id}")
    end
    change_column_null :users, :name, false # Add NOT NULL constraint
    add_index :users, :name, unique: true   # Add uniqueness constraint
  end
end
