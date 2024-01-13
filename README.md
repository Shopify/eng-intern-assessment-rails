### Features:

✔️ Support **CRUD Operations & Search functionality**

✔️ **Rate limit** to maximum 20 GET requests/minute per IP address

✔️ **Cache articles** to improve performance. Update cache when edit/delete an article

### Environment setup

```
bundle install
rails db:migrate
rails db:migrate RAILS_ENV=test
rails s
```

### Run tests

Make sure you've run db migration with `rails db:migrate RAILS_ENV=test`. Then run

```
rails test ./test/models/article_test.rb
```
