# == Schema Info
#
# Table name: article
#
#  id                  :integer        not null, primary key
#  title               :string         not null,
#  content             :string         
#  author              :string         
#  date                :datetime      
#

class Article < ActiveRecord::Base
    def self.search(query)
        # we check for query in title or content
        where("title LIKE :query OR content LIKE :query", query: "%#{query}%") 
    end 
end
