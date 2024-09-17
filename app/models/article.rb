class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true

  #@description a function which returns all articles which match the parameters with the table attributes
  def self.search(search)
    if search
      @articles = self.where("title LIKE :q or author LIKE :q or content LIKE :q", q: "%#{search}%")
    else
      @articles = self.all
    end
  end
end
