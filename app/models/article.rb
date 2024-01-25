class Article < ApplicationRecord
	validates :title, presence: true
	validates :content, presence: true, length: { minimum: 10 }

	def self.search(search)
		if search
			key = "%#{search}%"
			self.where("title LIKE ? OR author LIKE ? OR content LIKE ?", key, key, key)
		else
			@articles = Article.all
		end
	end
end
