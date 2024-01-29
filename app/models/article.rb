class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 10 }
  validates :author, presence: false
  validates :date, presence: false

  def self.search(search)
    result = nil
    if search
        result = where(["title LIKE ? OR content LIKE ? OR author LIKE ?","%#{search}%", "%#{search}%", "%#{search}%"])
    return result
    end
  end
end
