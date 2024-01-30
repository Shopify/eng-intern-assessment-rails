class Article < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 10 }

  #
  # return articles where title, content, or author contains the search term
  # or return all articles if the search term is empty
  #
  def self.search(term)
    if term.empty?
      all
    else
      # use sanitized search term for query
      # see documentation below:
      # https://api.rubyonrails.org/v7.1.3/classes/ActiveRecord/Sanitization/ClassMethods.html#method-i-sanitize_sql_like
      where('title LIKE :term OR content LIKE :term OR author LIKE :term', term: "%#{sanitize_sql_like(term)}%")
    end
  end
end
