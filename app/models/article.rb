class Article < ApplicationRecord

 has_one_attached :image

  validates :title, presence: true
  validates :content, presence: true
  validates :author, presence: true
  validates :date, presence: true

end
