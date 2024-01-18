class Article < ApplicationRecord
	validates :title, :content, presence: true

	# Search method
	# search_term is a wild card for both title and content
	def self.search(search_term)
		if search_term
				where('title LIKE ? OR content LIKE ?', "%#{search_term}%", "%#{search_term}%")
		else
				all
		end
	end
end
