class Rack::Attack
  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

  Rack::Attack.throttle("get_requests", limit: 20, period: 1.minute) do |request|
    request.ip if request.get?
  end

  Rack::Attack.throttled_responder = lambda do |env|
    retry_after = (env['rack.attack.match_data'] || {})[:period]
    [429, {'Content-Type' => 'text/html', 'Retry-After' => retry_after.to_s}, [File.read(Rails.root.join('public', '429.html'))]]
  end
end
