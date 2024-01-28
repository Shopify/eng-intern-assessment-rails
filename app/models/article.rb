class Article < ApplicationRecord
    validates :title, presence: true, length: { maximum: 300 }
    validates :body, presence: true, length: { minimum: 10 }
    validates :author, presence: true, length: { maximum: 100 }    

end
