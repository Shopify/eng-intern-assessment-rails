module Repositories
  module Article
    module ArticleRepository
      ## Interface
      def all
        raise NotImplementedError
      end

      def find(id)
        raise NotImplementedError, "Not implemented"
      end

      def create(article_params)
        raise NotImplementedError, "Not implemented"
      end

      def update(article, article_params)
        raise NotImplementedError, "Not implemented"
      end

      def destroy(article)
        raise NotImplementedError, "Not implemented"
      end

      def search(search_params)
        raise NotImplementedError, "Not implemented"
      end
    end
  end
end
