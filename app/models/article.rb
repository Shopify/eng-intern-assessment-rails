# frozen_string_literal: true

class Article < ApplicationRecord
  scope :search, ->(name) {
    where("title like ? or content like ?", "%#{name}%", "%#{name}%")
  }
  # Ensure title is always present, as we use it for routing
  validates :title, presence: true

  # Restrict the length of the title to be at least 1 character and at most 255
  validates :title, length: { maximum: 255, minimum: 1 }
end
