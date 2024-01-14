class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true

    def self.search(term)
        where('title LIKE :term OR content LIKE :term', term: "%#{term}%")
      end
end
