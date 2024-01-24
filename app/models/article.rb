# Author: Justin Bishop
# Date: January 2024
# Purpose: Shopify Internship Application

class Article < ApplicationRecord

    # validations for our article model
    validates :title, presence: true
    validates :content, presence: true, length: { minimum: 10 }
    validates :author, presence: true
    validates :date, presence: true
    validates_uniqueness_of :title

    # search method for our article model
    def self.search(query)
      where("title LIKE ? OR content LIKE ? OR author LIKE ?", "%#{query}%", "%#{query}%", "%#{query}%")
    end
  end
  