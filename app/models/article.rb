class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  def self.search(search)
    search = search.strip
    if search
      result = where("title LIKE ? OR content LIKE ?","%#{search}%",
      "%#{search.strip}%")
    end
    return result
  end
end
