class Article < ApplicationRecord
    # title and content are mandatory. date and author are not 
    validates :title, presence: true
    validates :content, presence: true

end
