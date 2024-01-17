# Article model
class Article < ApplicationRecord
  # Ensure Title and Content fields are present.
  validates :title, :content, presence: true
  # Ensure Content is unique.
  validates :content, uniqueness: true
  # Ensure Title is unique per Author.
  validates :title, uniqueness: { scope: :author, message: 'must be unique per author' }


end
