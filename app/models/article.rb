class Article < ApplicationRecord
  def self.search(search_arg)
    if search_arg
      where('title LIKE ? OR content LIKE ?', "%#{search_arg}%", "%#{search_arg}%")
    else
      nil
    end
  end

  def self.title(search_arg)
    if search_arg
      where('title LIKE ?', "%#{search_arg}%")
    else
      nil
    end
  end

  def self.author(search_arg)
    if search_arg
      where('author LIKE ?', "%#{search_arg}%")
    else
      nil
    end
  end
end
