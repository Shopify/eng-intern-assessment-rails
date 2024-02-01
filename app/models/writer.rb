class Writer < ApplicationRecord
  # Devise modules for authentication:
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
      :recoverable, :rememberable, :validatable
  # Association with Articles:
  has_many :articles
  
end
