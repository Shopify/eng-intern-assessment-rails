class Article < ApplicationRecord
  has_one_attached :cover_photo

  validates :title, presence: true
  validates :content, presence: true, length: {minimum: 5}
  validates :cover_photo, content_type: {in: ['image/png', 'image/jpg', 'image/jpeg'],
                                         message: "must be .png, .jpg, or .jpeg file format"}

  def self.search(query)
    if query.present?
      # sqlite "LIKE" is case-sensitive
      where("LOWER(title) LIKE :query OR LOWER(content) LIKE :query OR LOWER(author) LIKE :query", query: "%#{query.downcase}%")
    else
      # display all searches if query is nil (i.e. URL is /search)
      all
    end
  end
end
