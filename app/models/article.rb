class Article < ApplicationRecord
	  def self.search(query)
    if query
      where("title LIKE :query OR content LIKE :query", query: "%#{query}%")
    else
      all
    end
  end
end
