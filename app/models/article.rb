class Article < ApplicationRecord
  def self.search(search_term)
    if search_term
      terms = search_term.split

      query = terms.each_with_index.map { |term, index| 
        "title LIKE :term#{index} OR content LIKE :term#{index}" } 
        .join(' OR ')

      term_bindings = terms.each_with_index.to_h { |term, index| 
        [:"term#{index}", "%#{term}%"]  
      }

      where(query, term_bindings)
    end
  end

  validates :title, presence: true
  validates :content, presence: true, length: { minimum: 10 }
  
end
