class Article < ActiveRecord::Base
  # ensure that title and content are present
	validates :title, presence: true
	validates :content, presence: true

  # search for articles with title or content containing query
	def self.search(query)
		Article.where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
	end
end
