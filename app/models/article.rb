# frozen_string_literal: true

# Model for our Article class
class Article < ApplicationRecord
  # Defined search method, simple include search trying to match by title or content, I would change the name
  # for a less generic name (WIP)
  def self.search(this_thing)
    @selected_articles = Article.all.select do |article|
      article['title'].include?(this_thing) || article['content'].include?(this_thing)
    end
  end
end
