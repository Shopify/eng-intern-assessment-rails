class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 1 }
  # Need to add date field

  def self.search(query)
    unless query.strip.empty?
      where("lower(title) like :searchQuery or lower(content) like :searchQuery", searchQuery: "%#{query.downcase}%")
    else
      all
    end
  end

end
