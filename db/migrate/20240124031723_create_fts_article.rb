class CreateFtsArticle < ActiveRecord::Migration[7.1]
  self.verbose = false
  def up
    execute("CREATE VIRTUAL TABLE fts_articles USING fts5(author, title, content, article_id)")
  end

  def down
    execute("DROP TABLE IF EXISTS fts_articles")
  end
end
