class ChangeDateDefault < ActiveRecord::Migration[7.1]
  def change

    # source: https://stackoverflow.com/questions/9090204/rails-migration-set-current-date-as-default-value
    change_column_default :articles, :date, -> {'CURRENT_DATE'}
  end
end
