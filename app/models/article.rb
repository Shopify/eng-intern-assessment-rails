class Article < ApplicationRecord
    def self.search(term)
        where('title LIKE :term OR content LIKE :term', term: "%#{term}%")
      end
end
