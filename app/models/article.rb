class Article < ApplicationRecord
    def self.search(searchText)
        where("lower(title) LIKE :search or lower(content) LIKE :search", search: "%#{searchText.downcase}%")
    end
    validates :title, presence: true
  validates :content, presence: true
  validates_uniqueness_of :title, case_sensitive: false
end
