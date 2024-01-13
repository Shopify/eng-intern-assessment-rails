class Rack::Attack
  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

  Rack::Attack.throttle("get_requests", limit: 20, period: 1.minute) do |request|
    request.ip if request.get?
  end

  Rack::Attack.throttled_response = lambda do |env|
    [429, {'Content-Type' => 'text/html'}, [File.read(Rails.root.join('public', '429.html'))]]
  end
end
