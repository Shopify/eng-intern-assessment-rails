class Article
  attr_accessor :title, :content, :author, :date, :id
  @@articles = []
  @@id = 0

  def initialize(title="", content="", author="", date="")
    @title = title
    @content = content
    @author = author
    @date = date
    @id = @@id

    @@id += 1
  end

  # Section for class's methods

  def self.clear!()
    @@articles = []
    @@id = 0
  end

  def self.count()
    return @@articles.length
  end
 
  def self.search(query)
    result = []

    @@articles.each { |article| result.append(article) if article.content.include?(query) || article.title.include?(query) }

    return result
  end

  def self.create(args = {})
    # Set attributes to respective arguments if they are passed in, else set them to an empty string
    title = args[:title] || ""
    content = args[:content] || ""
    author = args[:author] || ""
    date = args[:date] || ""
  
    article = Article.new(title, content, author, date)
    @@articles.append(article)

    return article
  end

  def self.find(target_id)
    @@articles.each { |article| return article if article.id() == target_id }

    raise ActiveRecord::RecordNotFound
  end 

  # Section for class instances' methods

  def valid?()
    return @@articles.include?(self)
  end

  def update(args = {})
    # Only update attributes if they are passed through the argument
    @title = args[:title] || @title
    @content = args[:content] || @content
    @author = args[:author] || @author
    @date = args[:date] || @date
  end

  def destroy()
    target_id = @id

    @@articles.each { |article| @@articles.delete(article) if article.id() == target_id }
    
    @title, @content, @author, @date, @id = nil
  end 
  
end
