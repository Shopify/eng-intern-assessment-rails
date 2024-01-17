require 'redis'

## Added rescue condition if Redis connection is failed
begin
  $redis = Redis.new(:host => Rails.configuration.redis_host, :port => Rails.configuration.redis_port)
rescue Exception => e
  puts e
end
