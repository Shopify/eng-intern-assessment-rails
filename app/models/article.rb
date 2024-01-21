class Article < ApplicationRecord
  def self.search(search_arg)
    if search_arg
      where('title LIKE ? OR content LIKE ?', "%#{search_arg}%", "%#{search_arg}%")
    else
      nil
    end
  end
end
