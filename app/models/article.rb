class Article < ApplicationRecord
  include ActiveModel::Validations
  validates :title, presence: true
  validates :content, presence: true
  validate :author 

  def self.search(search)
    if search.present?
      articles = Article.where("title LIKE :search OR content LIKE :search", search: "%#{search}%")
    else
      []
    end
  end
end
