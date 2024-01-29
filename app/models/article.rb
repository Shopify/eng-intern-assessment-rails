# frozen_string_literal: true

# Article model that represents an article in the database.
class Article < ApplicationRecord
  # Set the default date and author before validation if they haven't been explicitly defined.
  before_validation :set_default_date
  before_validation :set_default_author

  validates :title, presence: true
  validates :content, presence: true
  validates :author, presence: true
  validates :date, presence: true

  def self.search(search_term)
    where('title LIKE ? OR content LIKE ?', "%#{search_term}%", "%#{search_term}%")
  end

  private

  def set_default_date
    self.date ||= Time.now
  end

  def set_default_author
    return unless author.nil? || author.empty?

    self.author = 'Anonymous'
  end
end
