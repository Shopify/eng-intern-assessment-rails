# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :article
  validates :username, presence: true, allow_blank: false
  validates :body, presence: true, allow_blank: false

  class << self
    # Create a new Comment instance.
    def create(username:, body:, article_id:)
      comment = Comment.new(username: username, body: body, article_id: article_id)
      comment.save

      comment
    end
  end
end
