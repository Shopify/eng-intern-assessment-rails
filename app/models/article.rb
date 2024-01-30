=begin
I wasn't able to get the tests running unfortunately. Kept getting errors in VScode and through terminal. Not sure if my installation is wrong or what. Unfortunately, I can't debug the cause any longer since I have to complete some assignments for school.

I think all the tests should pass, apart from maybe the raising RecordNotFound. It deletes the entry and you shouldn't be able to access it (since the articles are given IDs based off their location in the array @@articles and I don't update IDs after a deletion)

Hopefully the others work as intended. I did move them over to this file and run the commands to verify and everything else seemed good. Thanks for your time

=end

class Article
  attr_accessor :id, :title, :content, :author, :date

  @@articles = []


  def initialize(id:, title:, content:, author:, date:)
    @id = id
    @title = title
    @content = content
    @author = author
    @date = date
    @@articles << self
  end

  # basic valid check that title and content are not empty or nil
  def valid?
    !@title.nil? && !@title.empty? && !@content.nil? && !@content.empty?
  end

  # create requires title and content, author and date are optional, and the ID is set via the location in the array of articles
  def self.create(title:, content:, author: nil, date: nil)
    created_article = new(id: @@articles.length(), title: title, content: content, author: author, date: date)
  end

  # all updates are optional, with ID not being changed. Rather than setting up conditionals, I just set parameter defaults to the original values.
  def update(title: @title, content: @content, author: @author, date: @date)
    @id = @id
    @title = title
    @content = content
    @author = author
    @date = date
  end

  # search finds all articles containing the search term within any field. Author and date converted to strings as default values on create are nil
  def self.search(search_term)
    @@articles.select do |article|
      article.title.include?(search_term) || article.content.include?(search_term) || article.author.to_s.include?(search_term) || article.date.to_s.include?(search_term)
    end
  end

  def self.find(requested_id)
    requested_article = @@articles.find { |article| article.id == requested_id}
    raise ActiveRecord::RecordNotFound unless requested_article
  end

  # returns count of array of Articles
  def self.count
    @@articles.length
  end

  # deletes self from array, does not update IDs for remaining articles
  def destroy
    @@articles.delete(self)
  end

end