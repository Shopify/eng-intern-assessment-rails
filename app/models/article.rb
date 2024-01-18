class Article < ApplicationRecord
  # Searches for records that contain the given search terms in their title or content.
  # The method splits the search term into individual terms, then constructs a query
  # to find records where the title or content contains ANY of these terms.
  #
  # @param search_term [String] The search term(s) to query.
  # @return [ActiveRecord::Relation] A relation containing records that match the search criteria.
  # @note SECURITY: index is an internal constant - not provided by user.

  def self.search(search_term)

    terms = search_term.split

    # SECURITY: index is an internal constant - not provided by user
    query = terms.each_with_index.map do |term, index| 
      [
        "title LIKE :term#{index}",
        "content LIKE :term#{index}",
        "author LIKE :term#{index}",
        "date LIKE :term#{index}"
      ].join(' OR ')
    end.join(' OR ')
    
    term_bindings = terms.each_with_index.to_h { |term, index| 
      [:"term#{index}", "%#{term}%"]  
    }

    where(query, term_bindings)
  end

  validates :title, presence: true 
  validates :content, presence: true, length: { minimum: 10 }
  validates :author, presence: true
  validates :date, presence: true
end
