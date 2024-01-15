class User < ApplicationRecord
  has_many :articles, primary_key: 'uid', foreign_key: 'user_id'
end
