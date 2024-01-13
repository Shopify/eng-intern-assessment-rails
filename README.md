## Demo:

[Rails app demo.webm](https://github.com/anhminhtran235/eng-intern-assessment-rails/assets/54651212/1108e850-8158-43e0-a1c1-06046b88e6c7)

## Features:

✔️ Support **CRUD Operations & Search functionality**

✔️ **Rate limit** to maximum 20 GET requests/minute per IP address

✔️ **Cache articles** to improve performance. Update cache when edit/delete an article

✔️ **Seed data** for ease of development and testing

## Environment setup

```
bundle install
rails db:migrate
rails db:migrate RAILS_ENV=test
rails db:seed
rails s
```

## Run tests

Make sure you've run db migration with `rails db:migrate RAILS_ENV=test`. Then run

```
rspec
```

OR

```
rails test ./test/models/article_test.rb
```
