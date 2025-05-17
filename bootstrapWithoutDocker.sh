bundle install
rails db:reset
rails db:migrate
rails test && rails server
