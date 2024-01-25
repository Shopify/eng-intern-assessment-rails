class Article < ApplicationRecord
	
  # search based on title or content
  def self.search(query)
    if query
      #puts "hello"
      where("title LIKE :query OR content LIKE :query", query: "%#{query}%")
    else
      all
    end
  end

  def self.search_by_author(query)
    where("author LIKE :query", query: "%#{query}%")
  end
  #get the names of all the authors for authors page
  def self.all_authors
    distinct.pluck(:author)

  end
end
