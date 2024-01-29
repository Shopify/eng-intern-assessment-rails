require_relative '../config/environment'
require 'benchmark'

# Benchmark function parameters
sort_column = 'content'
sort_direction = 'asc'
cache_key = "articles/#{sort_column}/#{sort_direction}"

# Number of times to run the benchmark
number_of_runs = 100

Benchmark.bm do |x|
  x.report("No Cache") do
    number_of_runs.times do
      @articles_without_cache = Article.order("#{sort_column} #{sort_direction}")
    end
  end

  x.report("Cache") do
    number_of_runs.times do
      @articles_with_cache = Rails.cache.fetch(cache_key, expires_in: 1.hour) do
        Article.order("#{sort_column} #{sort_direction}")
      end
    end
  end
end
