class Article < ApplicationRecord
  before_validation :default_values # check if default values are required before validation
  validates :title, :content, :author, :date, presence: true # require all fields

  # Sets author to 'Anonymous' if it is not already set
  def default_values
    unless self.author?
      self.author = 'Anonymous' # set author to 'Anonymous' if not set
    end
    self.date ||= Date.today # if date is nil set to Date.today
  end

  # Searches for articles that have a matching title or content.
  #
  # @param search [String] The search query.
  # @return [ActiveRecord::Relation<Article>] An ActiveRecord relation of articles that match the search query.
  def self.search(search)
    where("title LIKE ? or content LIKE ?", "%#{search}%", "%#{search}%")
  end

end
