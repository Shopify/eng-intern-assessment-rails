class Article < ApplicationRecord
  '''
  TODO: Add validations for the model attributes depending on the requirements.
  The tests do not provide enough information to determine what validations are
  necessary. 
  '''
  
  scope :search, ->(query) {
    where("title LIKE :query OR content LIKE :query", query: "#{query}%")
  }
end