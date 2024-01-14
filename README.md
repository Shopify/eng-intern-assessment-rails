# Setup
1. Clone the repository and download ruby 2.7.6.
2. Run `bundle install` in the root directory to download the dependencies.

# Running & Testing the Application
1. Run `rails db:create` then `rails db:migrate` to create the local database instances.
1. Run `rails server` to start the application on `http://127.0.0.1:3000`.
3. Run `rails test test/models/article_test.rb` to run the test cases.

# Project Overview
My simple rails application allows for the CRUD operations of articles as well as a search option to allow users to search for articles that exist in the database.


## Home Page
The home page displays the list of all current articles, with the option to search for articles, create articles, and explore existing articles.

![Home page](/images/home.png)


## Create Article
The create option allows users to input a title, content, author, and a date for their new article.

![Create page](/images/create.png)


## Article Page
Each article page allows users to view the title, author, date, and buttons to edit and delete articles, as well as a back button to navigate back to the home page.

![Article page](/images/article.png)


## Edit Page
Each editing page allows users to edit any of the fields: title, content, author, and date.

![Edit page](/images/edit.png)