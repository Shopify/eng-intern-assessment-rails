# frozen_string_literal: true

# Article model
class Article < ApplicationRecord
  class << self
    # Create a new Article instance.
    def create(title:, content:, author: "Anonymous", date: Time.zone.today)
      article = Article.new(author: author, title: title, content: content, date: date)
      article.save

      article
    end
  end
end
