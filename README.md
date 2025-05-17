# Setup
1. Clone this repo to your local environment using `git clone`
2. Install dependencies using `bundle install` - expects <b> Ruby</b> version "3.2.3" 
3. Run the migration using `bin/rails db:migrate`. If this does not work, try `rake db:schema:load`
4. Run rails server using `rails s`.
5. Run tests by `rails t test/models/article_test.rb`.


# Routes

1. Index: Lists all articles

   GET /

   GET /articles


2. Show: Displays an article selected by its ID
   
   GET /articles/:id

   GET /articles/:id.json


3. New: Displays the form to make a new article

   GET /articles/new


4. Create: Handles the submission of the form to create a new article
   
   POST /articles

   POST /articles.json


5. Edit: Displays the form to edit an existing article selected by ID

   GET /articles/:id/edit


6. Update: Submits an update to an existing article by ID

   PUT /articles/:id

   PUT /articles/:id.json


7. Destroy: Deletes an existing article by ID

   DELETE /articles/:id
   
   DELETE /articles/:id.json


8. Search: Displays articles that have the query in either title, author, or content

   GET /articles?search=query