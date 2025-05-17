# frozen_string_literal: true

class Article < ApplicationRecord
  attribute :date, :date, default: Date.today

  class << self
    def search(query)
      where("title LIKE ? OR content LIKE ? OR author LIKE ?", "%#{query}%", "%#{query}%", "%#{query}%")
    end
  end
end
