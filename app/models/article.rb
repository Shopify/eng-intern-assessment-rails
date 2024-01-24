class Article < ApplicationRecord

  # Validation to check for the presence of both the title and content, if they are not at least one
  validates :title, presence: true
  validates :content, presence: true

  def self.search(search_query)
    where("title LIKE ? or content LIKE ?", "%" + search_query + "%", "%" + search_query + "%")
  end
end
