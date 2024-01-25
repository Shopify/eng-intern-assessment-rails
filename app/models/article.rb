class Article < ApplicationRecord
	validates :title, presence: true
	validates :content, presence: true, length: { minimum: 10 }
	validates :author, presence: true, length: { maximum: 30 }


	# returns articles matching the search term
	def self.search(search)
		if search
			# searches for the search term in any part of article's title, content or author
			key = "%#{search}%"
			self.where("title LIKE ? OR author LIKE ? OR content LIKE ?", key, key, key)
		else
			@articles = Article.all
		end
	end
end
