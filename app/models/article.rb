class Article < ApplicationRecord
    validates :title, presence: true, length: { maximum: 300 }
    validates :content, presence: true, length: { minimum: 1 }
    validates :author, length: { maximum: 100 }    

end
