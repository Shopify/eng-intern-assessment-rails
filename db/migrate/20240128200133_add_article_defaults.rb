class AddArticleDefaults < ActiveRecord::Migration[7.1]
  def change
    # set article author to anonymous if not specified
    change_column_default(:articles, :author, 'Anonymous')
    # set article date to now if not specified
    change_column_default(:articles, :date, -> { 'CURRENT_TIMESTAMP' })
  end
end
