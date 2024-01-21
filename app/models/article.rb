# frozen_string_literal: true

class Article < ApplicationRecord
  validates :title, presence: true, length: { minimum: 3, maximum: 100 }, uniqueness: true

  class << self
    def search(search_term)
      if search_term.present?
        where(
          "title LIKE :query OR content LIKE :query OR author LIKE :query OR date LIKE :query",
          query: "%#{search_term}%",
        )
      else
        all
      end
    end
  end
end
