class Article < ApplicationRecord
  # Validate rules checking to see the presence of the title and content.
validates :title, :content, presence: true

# The `search` class method allows for searching articles by title, content, or author.
# If a search term is provided, it returns all articles where the title, content, or author matches the term.
# If no term is provided, it returns all articles.
def self.search(term)
  if term
    where('title LIKE ? OR content LIKE ? OR author LIKE ?'  , "%#{term}%", "%#{term}%", "%#{term}%")
  else
    all
  end
end
end
