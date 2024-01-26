class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true
    # The validations below are commented out because the test attempts 
    # to create an article without author and date, however they may be 
    # of use in the future
    # validates :author, presence: true
    # validates :date, presence: true

    #def self.search(search)
      #if search
        #where('title LIKE ? OR content LIKE ? OR author LIKE ? OR DATE(date) = ?', 
       #       "%#{search}%", "%#{search}%", "%#{search}%", search)
      #else
      #  all
     # end
    #end


    def self.search(search)
      if search.present? #ensures that search term is not empty
        where('title LIKE ? OR content LIKE ? OR author LIKE ? OR DATE(created_at) = ?', 
              "%#{search}%", "%#{search}%", "%#{search}%", search)
      else
        none #to ensure that no results are returned if the search bar is blank
      end
    end

  end
    
  