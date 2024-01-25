class Article < ApplicationRecord
	
  def self.search(query)
    if query
      where("title LIKE :query OR content LIKE :query", query: "%#{query}%")
    else
      all
    end
  end

  def self.search_by_author(query)
    where("author LIKE :query", query: "%#{query}%")
  end

  def self.all_authors
    distinct.pluck(:author)

  end
end
