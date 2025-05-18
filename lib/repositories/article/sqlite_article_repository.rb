module Repositories
  module Article
    class SqliteArticleRepository
      include ArticleRepository

      def all
        AR::Article.all.map { |record| build_domain_model(record) }
      end

      def find(id)
        record = find_record(id)
        build_domain_model(record) if record
      end

      def create(domain_model)
        record = AR::Article.create(
          attributes_for_record(domain_model)
        )
        build_domain_model(record)
      end

      def update(article, attributes)
        article_record = find_record(article.id)
        article_record.update(attributes)
        build_domain_model(article_record)
      end

      def destroy(article)
        article_record = find_record(article.id)
        article_record.destroy if article_record
      end

      def search(query)
        results = AR::Article.search(query)
      end

      private

      def build_domain_model(record)
        Domain::Article.new(
          id: record.id,
          title: record.title,
          author: record.author,
          content: record.content,
          date: record.date,
        )
      end

      def find_record(id)
        AR::Article.find_by(id: id)
      end

      def attributes_for_record(domain_attributes)
        {
          title: domain_attributes.title,
          author: domain_attributes.author,
          content: domain_attributes.content,
          date: domain_attributes.date,
        }
      end
    end
  end
end
