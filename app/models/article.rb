class Article < ApplicationRecord

def self.search(term)
    if term.present?
      where('title LIKE ? OR content LIKE ?', "%#{term}%", "%#{term}%")
    else
      all
    end
 end



end
