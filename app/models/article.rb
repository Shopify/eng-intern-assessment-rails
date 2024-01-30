class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  def self.search(term)
    if term.present?
      where('title LIKE ? OR content LIKE ?', "%#{term}%", "%#{term}%")
    else
      all
    end
  end
end
