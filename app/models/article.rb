class Article < ApplicationRecord
  # title and content must be present & unique
  validates_presence_of :title, :content
  validates_uniqueness_of :title, :content, case_sensitive: false, message: 'must be unique'
  # Set the date to today's date if it's not specified
  after_initialize :set_default_date

  # Search for articles where the title or content contain a specified query.
  #
  # @param query [String] The search term to be used in the query.
  # @return [ActiveRecord::Relation] A scope containing the filtered records.
  def self.search(query)
    sanitized_query = sanitize_sql_like(query)
    where("title LIKE ? OR content LIKE ?", "%#{sanitized_query}%", "%#{sanitized_query}%")
  end

  private

  def set_default_date
    self.date ||= Date.today
  end
end
