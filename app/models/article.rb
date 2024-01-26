class Article < ApplicationRecord
  validates :title, presence: { message: "Title can not be blank!"}
  validates :content, presence: { message: "Content can not be blank!"}

  def self.search(query)
    if query.present?
      sanitized_query = query.gsub(/\s+/, ' ') # Replace consecutive spaces with a single space
      where("title LIKE ? OR content LIKE ? OR author LIKE ?", "%#{sanitized_query}%", "%#{sanitized_query}%", "%#{sanitized_query}%")
    else
      none
    end
  end

end
