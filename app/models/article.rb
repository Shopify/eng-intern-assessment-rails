class Article < ActiveRecord::Base
	validates :title, presence: true
	validates :content, presence: true

	def self.search(query)
		Article.where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
	  end
end
