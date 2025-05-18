class Article < ApplicationRecord
    after_initialize :set_defaults
    before_validation :set_defaults, on: :create
  
    def set_defaults
      self.date ||= DateTime.now
    end
  
    def self.search(text)
      return Article.where("title LIKE ? OR content LIKE ?", "%#{text}%", "%#{text}%")
    end
  end