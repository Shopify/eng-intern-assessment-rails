ActiveRecord::Schema.define(version: '2024_01_27_045809') do
  # Create the articles table
  create_table 'articles', force: :cascade do |t|
    # The title of the article
    t.string 'title'
    # The content of the article
    t.text 'content'
    # The author of the article
    t.string 'author'
    # The date of the article
    t.date 'date'
    # The date and time when the article was created
    t.datetime 'created_at', null: false
    # The date and time when the article was last updated
    t.datetime 'updated_at', null: false
  end
end