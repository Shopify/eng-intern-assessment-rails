# frozen_string_literal: true

class Article < ApplicationRecord
  scope :search, ->(name) {
    where("title like ?", name)
  }
end
