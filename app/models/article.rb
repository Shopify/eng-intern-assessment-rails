class Article < ApplicationRecord
  validates :title, presence: { message: "Title can not be blank!"}
  validates :content, presence: { message: "Content can not be blank!"}

  def self.query(query)
    if query.present?
      where("title LIKE ? OR content LIKE ? OR author LIKE ?", "%#{query}%", "%#{query}%", "%#{query}%")
    else
      none
    end
  end

end
