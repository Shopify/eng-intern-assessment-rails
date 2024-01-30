class Article < ApplicationRecord
  validates :title, presence: true, length: {minimum: 1 }
  validates :content, presence: true, length: { minimum: 10 }
  validates :author, presence: false
  validates :date, presence: false


  def self.search(q)
    return Article.where("title LIKE ? OR content LIKE ? OR author LIKE ?",
     "%" + q + "%", "%" + q + "%", "%" + q + "%")
  end
end
