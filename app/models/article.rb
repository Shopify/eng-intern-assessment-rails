class Article < ApplicationRecord
    validates_presence_of :title
    validates_presence_of :content
    def self.search(str)
        where('title like ? OR content like ?', "%#{str.downcase}%", "%#{str.downcase}%")
    end
end
