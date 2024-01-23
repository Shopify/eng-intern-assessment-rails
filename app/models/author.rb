# frozen_string_literal: true

# Author model representing individuals contributing to the virtual encyclopedia.
# Stores the author's name for articles in the application.
class Author < ApplicationRecord
  has_many :articles

  validates :name, presence: true
end
