class Article < ApplicationRecord

  def self.search(query)
    if query.present?
      # sqlite "LIKE" is case-sensitive
      where("LOWER(title) LIKE :query OR LOWER(content) LIKE :query OR LOWER(author) LIKE :query", query: "%#{query.downcase}%")
    else
      all
    end
  end
end
