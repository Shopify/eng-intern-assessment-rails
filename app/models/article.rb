class Article < ApplicationRecord
  def self.search(search_term)
    if search_term
      where("lower(title) LIKE ? OR lower(content) LIKE ?", "%#{search_term.downcase}%", "%#{search_term.downcase}%")
    else
      all
    end
  end
end
