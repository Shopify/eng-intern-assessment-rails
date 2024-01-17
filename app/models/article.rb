class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  def self.search(search)
    search = search.strip
    result = nil
    if search
      result = where("LOWER(title) LIKE ? OR LOWER(content) LIKE ?",
      "%#{search.downcase.strip}%",
      "%#{search.downcase.strip}%")
    end
    return result
  end
end
