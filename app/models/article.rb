#define the class, it inherit the ApplicationRecord class
class Article < ApplicationRecord
    #some validations
    validates :title,presence: true
    validates :content, presence: true

    #Here, I first created a "search" scope to make sure case insensitive when it comes to search on the title 
    #and content of articles, also use SQL "Like" query to match the query
    scope :search, ->(query) { where('title Like ? OR content Like', "%#{query}%", "%#{query}%")}
end