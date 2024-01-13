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
  primary_abstract_class
end
