class Article < ApplicationRecord
  validates :title, :content, presence: true

  def self.search(querystr)
    query = 'LOWER(title) LIKE ? OR LOWER(content) LIKE ?'

    where(query, "%#{querystr.downcase}%", "%#{querystr.downcase}%")
  end
end
