// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

// clear input from search bar
function clearSearchBar() {
    document.getElementById('search-bar').reset();
}