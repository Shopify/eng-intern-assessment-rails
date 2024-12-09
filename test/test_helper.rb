ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # I removed fixtures from the file so they don't apply globally
    # If fixtures are needed we can add methods here so that tests
    # can create them on as needed basis
  end
end
