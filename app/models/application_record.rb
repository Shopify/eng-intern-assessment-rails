class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  #this is a method that takes in a parameter and searches the db and returns articles that includes the parameter#
  def self.search(key)
    key_param = "%" + key + "%"
    @articles = Article.where("lower(content) LIKE ? or lower(title) LIKE ?", key_param, key_param)
  end
end
