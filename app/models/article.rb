# frozen_string_literal: true

class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 5 }
  # scopes allow us to query for artists easily, minimizing and simplifying the code on the controller side if we would like to search per author. (as is best practice)
  # I was going to use it for a feature, but ultimately decided against it.
  # scope :author, -> (query){where(author: query)}

  def self.search(query)
    query = "%#{query}%"

    # using sql queries, wildcard regex. Rails protects us from sql injection automatically.
    # alternate method: chain calls to scope queries.
    where('title LIKE ? OR content LIKE ? OR author LIKE ?', query, query, query)
  end
end
