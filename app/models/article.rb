class Article < ApplicationRecord
  def self.search(query)
    where("title LIKE :search OR content LIKE :search", search: "%#{query}%").order(title: :asc)
  end
end
