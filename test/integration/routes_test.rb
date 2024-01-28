require "test_helper"

class RoutesTest < ActionDispatch::IntegrationTest
  # probably a little overkill, so I only did it for a few routes
  #not a comprehensive set of tests, but enough to test some core features
  # https://guides.rubyonrails.org/routing.html#testing-routes
  # https://api.rubyonrails.org/classes/ActionDispatch/Assertions/RoutingAssertions.html
  test "routes correspond to right controllers and actions" do
    assert_routing({path: '/', method: :get}, {controller: 'articles', action: 'index'})
    assert_routing({path: 'articles/new', method: :get}, {controller: 'articles', action: 'new'})
    assert_routing({path: 'articles', method: :post}, {controller: 'articles', action: 'create'})
  end

end
