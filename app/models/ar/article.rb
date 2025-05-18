module AR
  class Article < ApplicationRecord
    include Search::SqliteFullTextSearch
    search_scope(:author, :title,:content)


    validates :title, presence: true
    validates :content, presence: true
  end
end
