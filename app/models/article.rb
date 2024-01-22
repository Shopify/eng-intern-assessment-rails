class Article < ApplicationRecord
    validates :title, presence: true
    validates :content, presence: true
    # The validations below are commented out because the test attempts 
    # to create an article without author and date, however they may be 
    # of use in the future
    # validates :author, presence: true
    # validates :date, presence: true

    def self.search(search)
      if search
        self.where('title LIKE ? OR content LIKE ?', "%#{search}%", "%#{search}%")
      else
        all
      end
    end
  end
  