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

  def self.clear!()
    @@articles = []
    @@id = 0
  end

  def self.all()
    return @@articles
  end

  def self.count()
    return @@articles.length
  end

  def self.search(query)
    returner = []
  
    for article in @@articles do
      if article.content.include?(query) || article.title.include?(query)
        returner.append(article)
      end 
    end 
  
    return returner
  end

  def self.create(options = {})
    title = options[:title] || ""
    content = options[:content] || ""
    author = options[:author] || ""
    date = options[:date] || ""
  
    article = Article.new(title, content, author, date)
    @@articles.append(article)
    return article
  end

  def self.find(target)

    for article in @@articles do 
      if article.id() == target
        return article
      end
    end

    raise ActiveRecord::RecordNotFound

  end 

  def valid?()
    @@articles.include?(self)
  end

  def title()
    return @title
  end

  def content()
    return @content
  end

  def update(options = {})
    @title = options[:title] || @title
    @content = options[:content] || @content
    @author = options[:author] || @author
    @date = options[:date] || @date
  end

  def id()
    return @id
  end

  def destroy()
    target_id = @id
  
    for article in @@articles do 
      if article.id() == target_id
        @@articles.delete(article)
      end
    end
  end 
  
end