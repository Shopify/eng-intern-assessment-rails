ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...

    # Added to clear the articles table before running each test
    # Without this test, 'test_starts_with_no_articles' and 'test_deletes_an_article' fails
    setup do
      Article.delete_all
    end

  end
end
