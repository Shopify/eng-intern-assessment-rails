# Schema for articles

ActiveRecord::Schema[7.1].define(version: 2024_01_15_124943) do
  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.string "author"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
