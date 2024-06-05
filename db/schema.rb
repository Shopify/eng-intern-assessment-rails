ActiveRecord::Schema[7.1].define(version: 2024_01_19_011425) do
  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.string "author"
    t.date "date"
  end
end
