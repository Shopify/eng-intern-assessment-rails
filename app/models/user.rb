class User < ApplicationRecord
  # Devise authentication
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  
  # relationship
  has_many :articles
end
