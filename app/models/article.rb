# frozen_string_literal: true

# Article model representing individual entries in a virtual encyclopedia.
class Article < ApplicationRecord
  belongs_to :author, optional: true
  accepts_nested_attributes_for :author

  validates :title, presence: true
  validates :content, presence: true

  before_validation :find_or_create_author

  def self.search(term)
    Article.all.where('title LIKE :search OR content LIKE :search', search: "%#{term}%")
  end

  private

  def find_or_create_author
    author_name = author&.name
    self.author = if author_name.nil? || author_name.empty?
                    nil
                  else
                    Author.find_or_create_by(name: author_name)
                  end
  end
end
