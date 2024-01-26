# app/models/domain/article.rb
module Domain
  class Article
    include ActiveModel::Model
    include ActiveModel::Validations
    attr_reader :id, :title, :author, :content, :date

    validates :title, :content, presence: true

    def initialize(attributes = {})
      @id = attributes[:id]
      @title = attributes[:title]
      @author = attributes[:author]
      @content = attributes[:content]
      @date = attributes[:date]
    end
  end
end
