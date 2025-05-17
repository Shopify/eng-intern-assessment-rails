# Projects Setup

1. `git clone` this repo to your local environment
2. Install dependencies with `bundle install`.
   <b> Ruby</b> version "3.2.3" as per Gemfile.
   <b> Bunder</b> version "2.3.3" as per Gemfile.lock.
3. (Optional) Generate migrations (new tables) by running `bin/rails generate migration CreateArticles`.
4. Run the migration by `bin/rails db:migrate`.
5. Run rails server by `rails server`.
6. Run tests by `rails test test/models/article_test.rb`. All tests should passed with the below message:
   > 11 runs, 19 assertions, 0 failures, 0 errors, 0 skips

# Routes included

1. Index and root: Lists all articles.
   GET /
   GET /articles
2. Show: Displays a specific article.
   GET /articles/:id
3. New: Shows the form to create a new article.
   GET /articles/new
4. Create: Handles the submission of the form to create a new article.
   POST /articles
5. Edit: Shows the form to edit an existing article.
   GET /articles/:id/edit
6. Update: Handles the submission of the form to update an existing article.
   PUT /articles/:id
7. Destroy: Deletes an existing article.
   DELETE /articles/:id
8. Custom Search:
   GET /articles?search=query

# Additional Implementations

Some additional functions were implemented in this app. However, they are open to adjustments if the behaviors are not desired.

1. Initially, there are no articles and "No articles found." is showing on the main page.
2. When creating an article, only <b>title</b> and <b>content</b> fields are required. The <b>author</b> and <b>date</b> fields could be left blank.
3. When deleting an article, a pop up window would show and asks the user to confirm the behavior. If users cancels the current delete, nothing would happen.
4. Once an article is deleted, users would be redirected to the main page, which presents a lists of all articles.

# Technical Instructions

1. Fork this repo to your local Github account.
2. Create a new branch to complete all your work in.
3. Test your work using the provided tests
4. Create a Pull Request against the Shopify Main branch when you're done and all tests are passing

# Project Overview

The Rails application you will be working on is an Encyclopedia, which allows users to create, view, edit, and delete articles. The application also provides search functionality to help users find relevant articles. Be sure to implement basic CRUD actions on articles. Your task is to implement these features as well as write the code that makes the tests pass.

# Project Goals

The main goal of this internship project is to implement the functionality required to make the existing tests pass. The provided tests cover various aspects of the application, including creating and viewing articles, editing and updating articles, deleting articles, and searching for articles. Along with completing the tests, be sure to implement all basic CRUD actions on your articles on a controller and create views to see your work in the app.

## Your specific goals for this project are as follows:

1. Review Existing Tests: Start by reviewing the existing tests provided in the article_test.rb file located in the test/models directory. Understand the requirements and expectations of each test.

2. Implement Functionality: Write the code necessary to make the existing tests pass. This involves implementing the required actions and logic in the models, controllers, and views to fulfill the specified requirements. Also be sure to implement basic CRUD actions and demonstrate proper MVC principals.

3. Ensure Code Quality: Write clean, well-structured, and maintainable code. Follow best practices and adhere to the Ruby on Rails conventions. Pay attention to code readability, modularity, and performance.

4. Test Your Code: After implementing the functionality, run the tests to ensure that they pass successfully. Fix any failures or errors that occur and retest until all tests pass.

5. Code Documentation: Document your code by adding comments and explanatory notes where necessary. This will help other developers understand your implementation and make future maintenance easier.

6. Version Control: Use Git for version control. Commit your changes regularly and push them to a branch in your forked repository.

7. Create a Pull Request: Once you have completed the project goals, create a pull request to merge your changes into the main repository. Provide a clear description of the changes made and any relevant information for the code review.

## Getting Started

To get started with this project, follow these steps:

1. Clone the repository to your local development environment.

2. Install the necessary dependencies by running bundle install in the project directory.

3. Familiarize yourself with the existing codebase, including the models, controllers, and views.

4. Review the existing tests in the article_test.rb file and understand their purpose and functionality.

5. Run the tests locally to ensure they are passing.

6. Start working on the goals outlined above, making improvements to the existing tests and adding new tests as needed.

7. Commit your changes regularly and push them to a branch in your forked repository.

8. Once you have completed the project goals, create a pull request to merge your changes into the main repository.

## Resources

Here are some resources that may be helpful during your internship project:

- [Ruby on Rails Guides](https://guides.rubyonrails.org/) - Comprehensive guides on Ruby on Rails, covering various aspects of web application development.

- [Ruby Style Guide](https://rubystyle.guide/) - A community-driven Ruby coding style guide to ensure consistent and readable code.

- [Git Documentation](https://git-scm.com/doc) - Official documentation for Git, the version control system used in this project.
