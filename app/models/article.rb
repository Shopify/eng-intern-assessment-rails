# define the Article class as an ActiveRecord model
# Inheriting from Application record
class Article < ApplicationRecord

  # Validates the presence of the 'title'
  validates :title, presence:true
  # Validates the presence of the 'content'
  validates :content, presence:true
  # Validates the presence of the 'date'
  # If no date is present, for example in the test, the 'date' validation will be skipped
  validates :date, presence:true, if: -> {date.present?}

  # Defines a scope named recent
  # Will order the articles by their date in descending order
  scope :recent, -> {order(date: :desc)}

  # Creation of a 'search' class to search for articles
  # Accepts a query string, and returns articles where the title or content includes said query
  def self.search(query)
    # Use of arel for a safer search method
    # First implementation idea was to use "LIKE" or "ILIKE" which was found out to not be as portable and creates problems with case sensitive searches
    # Arel solves these problems
    # Returns the recent articles if the query is not present in any articles
    return recent unless query.present?
    # Obtain Arel table from articles
    articles_table = self.arel_table
    # First condition to check if any title matches the query string
    title_matches = articles_table[:title].matches("%#{sanitize_sql_like(query)}%")
    # Second condition to check if any content matches the query string
    content_matches = articles_table[:content].matches("%#{sanitize_sql_like(query)}%")

    # Query for getting the articles that match the search query in the title or content
    matching_articles = where(title_matches.or(content_matches))
    # Order the results by relevance: first title matches, then content matches
    matching_articles.order(Arel.sql("CASE WHEN title LIKE'%#{sanitize_sql_like(query)}%' THEN 1 WHEN content LIKE '%#{sanitize_sql_like(query)}%' THEN 2 ELSE 3 END"))

  end

  # Instance method "recent?"
  # Determines if the article is recent (Published in the last seven days)
  def recent?
    self.date >= 7.days.ago
  end

  # 'before_save' callback which calls the 'default_values' method before saving the article
  before_save :default_values

  # Private controls the access to the methods in the class
  # In this case, access to 'default_values' is private
  private

  # Sets the date attribute to today's date if no date is provided
  def default_values
    self.date ||= Date.today
  end

  # Add an association to the Article model for an attached image using Active Storage
  has_one_attached :image

end
