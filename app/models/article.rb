class Article < ApplicationRecord
  # validations to ensure that title, content are necessary in creating an article
  # constraining the length of title and author for better readability on the front end
  validates :title, presence: true, length: { maximum: 300 }
  validates :content, presence: true, length: { minimum: 1 }
  validates :author, length: { maximum: 100 }    

  def self.search(search)
    # perform a search based on title and content through the database
    if search
      @articles = Article.where("title LIKE ? or content LIKE ?", "%#{search}%", "%#{search}%")
    else
      @articles = Article.all
    end
  end
end
