class ChangePublicationDateFieldToDateInArticles < ActiveRecord::Migration[7.1]
  def change
    rename_column :articles, :publication_date, :date
  end
end
