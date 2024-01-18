require 'simplecov'
SimpleCov.start 'rails'
require 'simplecov'
require 'simplecov-console'
SimpleCov.start do
  add_filter do |source_file|
    !['app/models/article.rb', 'app/controllers/articles_controller.rb'].include?(source_file.filename.gsub("#{SimpleCov.root}/", ''))
  end
end

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::Console
])

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
  end
end
