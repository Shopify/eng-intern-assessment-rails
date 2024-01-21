class Article < ApplicationRecord
  # Properties: title(String), content(String), date(Date), author(String)
  def self.search(search_term)
    # Searches for articles based on a case-insensitive match in title or content.
    # Returns all articles if no search term is provided.
    if search_term
      where("lower(title) LIKE ? OR lower(content) LIKE ?", "%#{search_term.downcase}%", "%#{search_term.downcase}%")
    else
      all
    end
  end
end
