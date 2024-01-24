# frozen_string_literal: true

class Article < ApplicationRecord
  scope :search, ->(name) {
    where("title like ? or content like ?", "%#{name}%", "%#{name}%")
  }
end
