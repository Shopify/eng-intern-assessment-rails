def self.search(term)
    where('title LIKE ? OR content LIKE ?', "%#{term}%", "%#{term}%")
  end
  