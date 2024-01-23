class Article < ApplicationRecord
  belongs_to :author, optional: true
  accepts_nested_attributes_for :author

  validates :title, presence: true
  validates :content, presence: true

  before_validation :find_or_create_author

  def self.search(term)
    Article.all.where("title LIKE :search OR content LIKE :search", search: "%#{term}%")
  end

  private
    def find_or_create_author
      author_name = self.author&.name
      if author_name.nil? or author_name.empty?
        self.author = nil
      else
        self.author = Author.find_or_create_by(name: author_name)
      end
    end
end
