class Article < ApplicationRecord
  def self.search(search)
    if search
      @articles = self.where("title LIKE :q or author LIKE :q or content LIKE :q", q: "%#{search}%")
    else
      @articles = self.all
    end
  end
end
