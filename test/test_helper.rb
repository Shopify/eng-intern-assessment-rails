ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

# Requirements for database cleaner tool
require "minitest/autorun"
require "database_cleaner/active_record"

DatabaseCleaner.strategy = :transaction

module MyCleaner

  # Concern --> encapsulate setup + teardown logic related to database_cleaner
  extend ActiveSupport::Concern

  included do
    DatabaseCleaner.strategy = :transaction
    setup do
      DatabaseCleaner.start
    end

    teardown do
      DatabaseCleaner.clean
    end
  end
end

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
  # Include database cleaner module in base class
  include MyCleaner
  end
end
