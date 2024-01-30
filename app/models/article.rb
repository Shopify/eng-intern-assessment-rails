class Article < ApplicationRecord
  belongs_to :user

  def self.search(query)
    where("title LIKE ? OR content LIKE ? OR author LIKE ? OR date LIKE ?",
          "%#{query}%", "%#{query}%", "%#{query}%", "%#{query}%")
  end
end
