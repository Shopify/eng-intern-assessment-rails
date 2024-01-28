#based off of the structure of the unit test article_test.rb,
#I'm creating an article class within the app/models directory
#that inherits from ActiveRecord::Base
#This is the class that will be used to create new articles
#in the database
class Article < ActiveRecord::Base
  #Next, I need to add search functionality to this Article class. We can do this by using a method.
  def self.search(query)
    where("title LIKE ? OR content LIKE ?", "%#{query}%", "%#{query}%")
  end
end
