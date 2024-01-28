require_relative '../config/environment'
require 'benchmark'

# Benchmark function parameters
sort_column = 'content'
sort_direction = 'asc'
cache_key = "articles/#{sort_column}/#{sort_direction}"

# Number of times to run the benchmark
number_of_runs = 100
total_time_without_cache = 0
total_time_with_cache = 0

number_of_runs.times do |i|
  puts "Run #{i + 1} of #{number_of_runs}"

  # Without cache
  time_without_cache = Benchmark.realtime do
    @articles_without_cache = Article.order("#{sort_column} #{sort_direction}")
  end
  total_time_without_cache += time_without_cache

  # With cache
  time_with_cache = Benchmark.realtime do
    @articles_with_cache = Rails.cache.fetch(cache_key, expires_in: 1.hour) do
      Article.order("#{sort_column} #{sort_direction}")
    end
  end
  total_time_with_cache += time_with_cache
end

average_time_without_cache = total_time_without_cache / number_of_runs
average_time_with_cache = total_time_with_cache / number_of_runs
times_ratio = average_time_without_cache / average_time_with_cache

puts "Average time without cache: #{average_time_without_cache} seconds"
puts "Average time with cache: #{average_time_with_cache} seconds"
puts "Caching is faster by: #{times_ratio} times"