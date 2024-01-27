# Article
#
# The Article class represents the articles in the application.
#
# Properties:
#   - title (String): The title of the article.
#   - content (String): The content or body of the article.
#
# Validations:
#   - Title:
#     - Presence: Ensures that the title is not empty.
#     - Length: Restricts the title length to a maximum of 50 characters.
#   - Content:
#     - Presence: Ensures that the content is not empty.
#     - Length: Restricts the content length to a maximum of 500 characters.
#
class Article < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 500 }

  # Search Method
  def self.search(search_term)
    where("LOWER(title) LIKE :term OR LOWER(content) LIKE :term", term: "%#{search_term.downcase}%")
  end
end
