class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true
    # The validations below are commented out because the test attempts 
    # to create an article without author and date, however they may be 
    # of use in the future
    # validates :author, presence: true
    # validates :date, presence: true

   
    #Allows user to search with title,content, and date.
    #Or just title/content
    #Or just date
    def self.search(search, date)
      if search.present? && date.present?
        where('(title LIKE ? OR content LIKE ? OR author LIKE ?) AND date = ?', 
              "%#{search}%", "%#{search}%", "%#{search}%", date)
      elsif search.present?
        where('title LIKE ? OR content LIKE ? OR author LIKE ?', 
              "%#{search}%", "%#{search}%", "%#{search}%")
      elsif date.present?
        where('date = ?', date)
      else
        none
      end
    end

  end
    
  