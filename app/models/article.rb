class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  # Returns all articles that match the search query or all articles if the search query is empty.
  def self.search(search)
    return Article.where(
        ['title LIKE ?', "%#{search}%"]).or(Article.where(['content LIKE ?', "%#{search}%"])
    ) if search
    return Article.all
  end

  # Returns the author of the article, or 'Anonymous' if no author is specified.
  def author
    return 'Anonymous' if self[:author].blank?
    return self[:author]
  end
end
