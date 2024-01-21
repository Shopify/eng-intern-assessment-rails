class Article < ApplicationRecord

  # Searches for articles based on a provided search argument.
  # The method looks for matches in both the title and content of the articles.
  # Returns nil if no search argument is provided.
  def self.search(search_arg)
    if search_arg
      where('title LIKE ? OR content LIKE ?', "%#{search_arg}%", "%#{search_arg}%")
    else
      nil
    end
  end

  # Searches for articles based on a provided search argument.
  # The method looks for matches in the title of the articles.
  # Returns nil if no search argument is provided.
  def self.title(search_arg)
    if search_arg
      where('title LIKE ?', "%#{search_arg}%")
    else
      nil
    end
  end

  # Searches for articles based on a provided search argument.
  # The method looks for matches in the author of the articles.
  # Returns nil if no search argument is provided.
  def self.author(search_arg)
    if search_arg
      where('author LIKE ?', "%#{search_arg}%")
    else
      nil
    end
  end
end
