# app/services/article_service.rb
module Services
  class ArticleService
    def initialize(repository)
      @article_repository = repository
    end

    def get_all_articles
      @article_repository.all
    end

    def create_article(params)
      article = Domain::Article.new(params)
      @article_repository.create(article)
    end

    def update_article(article, params)
      @article_repository.update(article, params)
    end

    def destroy_article(article)
      @article_repository.destroy(article)
    end

    def find_article(id)
      @article_repository.find(id)
    end

    private

    attr_reader :article_repository
  end
end
