class Article < ApplicationRecord
validates :author, presence: true
validates :title, presence: true
validates :content, presence: true

def self.search(term)
  if term
    where('title LIKE ? OR content LIKE ? OR author LIKE ?'  , "%#{term}%", "%#{term}%", "%#{term}%")
  else
    all
  end
end
end
