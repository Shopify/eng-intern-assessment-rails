# Articles Feature Pull Request

## Overview
This pull request introduces significant enhancements to our application, focusing on the implementation of the Articles feature. The changes made are designed to establish a solid foundation for article management within the application, offering essential CRUD (Create, Read, Update, Delete) functionality, along with a search feature.

## Changes Made
Here is a detailed breakdown of the key components and changes introduced by this pull request:

### ArticlesController
- Created the `ArticlesController` with the following actions:
  - `index`: Displays a list of articles.
  - `show`: Displays the details of a single article.
  - `new`: Renders the form to create a new article.
  - `create`: Handles the creation of new articles.
  - `edit`: Renders the form to edit an existing article.
  - `update`: Updates an existing article.
  - `destroy`: Deletes an article.

### Article Model
- Enhanced the `Article` model with validations for `title` and `content`, ensuring data integrity.
- Implemented a `search` method within the model to facilitate article queries, improving user experience and content discoverability.

### Database Migration
- Executed a database migration to create the `articles` table, incorporating fields for `title`, `content`, `author`, and `date`. This ensures that articles are stored in an organized manner within the database.


### Fixture Removal
- Removed fixtures for articles to align the testing and production environments, reducing potential inconsistencies.


## Testing
This pull request includes basic tests for the `ArticlesController` to ensure that the newly introduced functionality works as expected. Additionally, the changes have been thoroughly tested to prevent any potential issues in the application.

# Testing Command:
-`rake db:migrate RAILS_ENV=test`
-`ruby  bin/rails test test/models/article_test.rb`


Please review this pull request and provide your feedback. Your insights and suggestions are essential for the successful integration of these new features into our application.

Thank you for your time and attention to this important enhancement.
