class Comment < ApplicationRecord
  belongs_to :article
  validates :username, presence: true, allow_blank: false
  validates :body, presence: true, allow_blank: false
end
