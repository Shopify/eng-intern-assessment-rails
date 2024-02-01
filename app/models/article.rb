class Article < ApplicationRecord
  # association where each article belongs to a writer.
  belongs_to :writer
  # Defines an attribute 'date' with a data type of :date.
  attribute :date, :date

  
  def self.search(query)
    # Performs a search on Article records, looking for matches in the 'title' and 'content' fields.
    where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
  end
end
