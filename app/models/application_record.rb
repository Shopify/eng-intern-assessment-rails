class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class
end

class Article < ApplicationRecord
  before_create :set_default_values

  private

  def set_default_values 
    self.count = 0
  end
end