class Article < ApplicationRecord
    validates :title, :author, :content, :date, presence: true

end
