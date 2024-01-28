class User < ApplicationRecord
  # Devise authentication
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  
  # relationship between articles & users
  has_many :articles
end
