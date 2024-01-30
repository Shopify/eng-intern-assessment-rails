class Article < ApplicationRecord
  # Search for articles where the title or content contain a specified query.
  #
  # @param query [String] The search term to be used in the query.
  # @return [ActiveRecord::Relation] A scope containing the filtered records.
  def self.search(query)
    where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
  end
end
