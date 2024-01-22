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
      if self.author
        author_name = self.author.name

        # Find existing author or create a new one
        self.author = Author.find_or_create_by(name: author_name)
      end
    end
end
