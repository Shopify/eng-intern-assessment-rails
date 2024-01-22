class Article < ApplicationRecord
  belongs_to :author
  accepts_nested_attributes_for :author

  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 32 }
  validates :author, presence: true
  validates :date, presence: true

  before_validation :find_or_create_author

  private
    def find_or_create_author
      if self.author
        author_name = self.author.name

        # Find existing author or create a new one
        self.author = Author.find_or_create_by(name: author_name)
      end
    end
end
