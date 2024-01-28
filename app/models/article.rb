class Article < ApplicationRecord

    # validations to the model
    validates :title, presence: true
    validates :content, presence: true

    # search function here

end
