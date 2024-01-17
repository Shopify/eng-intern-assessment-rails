class Article < ApplicationRecord

  validates :title, presence: true #check if there is content
  validates :content, presence: true #check if there is content
  #Create search query to check if the title is like or the content is like the search parameter

  def self.search(search)
    if search
      self.where("title LIKE ? OR content LIKE ?", '%'+search+'%', '%'+search+'%')
    else
      self.all
    end
  end
end
