class Article < ApplicationRecord
  validates_presence_of :title
  validates_presence_of :content
end
