class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  def self.search(text)
    # lowercase to perform case insensitive search
    key = "%#{text.downcase}%"
    self.where("title LIKE ? or content LIKE ?", key, key)
  end
end
