class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  #takes in a parameter, adds % to the beginning and end of param
  #searches the db
  #then returns articles if title or content include the parameter
  #else returns empty array
  def self.search(query)
    query_param = "%" + query + "%"
    @articles = Article.where("lower(content) LIKE ? or lower(title) LIKE ?", query_param, query_param)
  end
end
