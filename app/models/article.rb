# frozen_string_literal: true

# Model for our Article class
class Article < ApplicationRecord
  # Defined search method, simple include search trying to match by title or content, I would change the name
  # for a less generic name (WIP)
  def self.search(substring)
    @selected_articles = Article.all.select do |article|
      article['title'].include?(substring) || article['content'].include?(substring)
    end
  end
end
