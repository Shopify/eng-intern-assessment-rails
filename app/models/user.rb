class User < ApplicationRecord
  # Devise modules for authentication:
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  # Association with Articles:
  
  has_many :articles
end
