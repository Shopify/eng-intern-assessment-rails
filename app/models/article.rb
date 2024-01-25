class Article < ApplicationRecord
  # Validation for required article fields
  validates :title, presence: true
  validates :content, presence: true
end
