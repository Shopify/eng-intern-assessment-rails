## Overview
This pull request addresses the implementation of CRUD actions for articles in the Encyclopedia Rails application, along with ensuring all tests pass as per the project's requirements.

## Article Model Schema

| Attribute | Data Type | Validations       | Notes                                   |
|-----------|-----------|-------------------|-----------------------------------------|
| title     | string    | presence: true    |                                         |
| content   | text      | presence: true    |                                         |
| author    | string    | -                 | Converted to nil if blank               |
| date      | datetime  | -                 | Converted to nil if blank               |

### Additional Model Details
- **Search Method:** Class method `search(term)` to search articles by `title`, `content`, `author`, or `date`.
- **Callbacks:** `before_validation :convert_empty_strings_to_nil` to handle blank author and date fields.


## Implemented Features
- **Article Creation:** Implemented the `create` action in the articles controller, enabling users to add new articles.
- **Article Viewing:** Developed views for `index` and `show` actions to list all articles and view individual articles, respectively.
- **Article Editing:** Added `edit` action, allowing users to modify existing articles.
- **Article Deletion:** Enabled article deletion through the `destroy` action.
- **Search Functionality:** Implemented a search feature to find articles based on keywords for any of the `title`, `content`, `author`, or `date` attributes.
- **Data Validation:** Client-side and server-side data validation.

## Tests and Code Quality
- Reviewed and passed all existing and new tests in `article_test.rb` and `articles_controller_test.rb`.
- Each test case aims to cover both the happy path and edge cases to ensure robustness in the functionality.
- Ensured code adheres to Ruby on Rails conventions and best practices for readability and maintainability.

### Model Tests Summary

Summary of the ADDITIONAL test cases:

1. **Create with Metadata**: Checks creation of articles with additional metadata.
2. **Create without Required Fields**: Tests failure to create articles missing mandatory fields.
3. **Error Messages for Missing Fields**: Verifies correct error messages for missing required fields.
4. **Update without Required Fields**: Tests failure to update articles missing mandatory fields.
5. **Allow Empty Metadata on Update**: Tests updating articles with empty metadata fields.
6. **Case-Insensitive Search**: Confirms search functionality is not sensitive to text casing.
7. **Search with No Results**: Checks behaviour when search yields no results.
8. **Empty Search Term**: Verifies all articles are returned when search term is empty.

### Controller Tests Summary

Summary of the test cases:

1. **Index Page Access**: Verifying the accessibility of the index page.
2. **Index Page with Search**: Testing the search functionality on the index page.
3. **Article Show**: Ensuring that individual articles can be viewed.
4. **Non-existent Article Handling**: Handling attempts to show, update, or destroy non-existent articles.
5. **New Article Page Access**: Testing access to the page for creating a new article.
6. **Article Creation**: Validating the creation of a new article with and without additional metadata (author, date).
7. **Article Creation Validations**: Ensuring articles aren't created when required fields are missing.
8. **Article Edit Page Access**: Checking access to the article editing page.
9. **Article Updating**: Testing the update functionality for articles with and without additional metadata.
10. **Article Update Validations**: Ensuring articles aren't updated when required fields are missing.
11. **Article Destruction**: Verifying that articles can be successfully deleted.
12. **Non-existent Article Destruction Handling**: Handling attempts to delete non-existent articles.

## Steps to Run the Test Suite
1. Run `bundle install` to install dependencies.
2. Execute `rails test` to run the tests and verify all are passing.

## Steps to Test In the Local Development Environment
1. Run `bundle install` to install dependencies.
2. Set up the database by running `rails db:setup` to create the database, load the schema, and initialize it with seed data.
3. Start the server using `rails server`.
4. Access the application at `http://localhost:3000`

## Screenshots
**Home Page**:
![image](https://github.com/johnsonduong/eng-intern-assessment-rails/assets/71087545/ac11508a-c91a-4c8c-b692-dfb4b0abf60b)
**Create Article Page**:
![image](https://github.com/johnsonduong/eng-intern-assessment-rails/assets/71087545/f2816943-57e1-4043-85c9-1f30cf38ed1c)
**Edit Article Page**:
![image](https://github.com/johnsonduong/eng-intern-assessment-rails/assets/71087545/3b5c3958-f5cc-4341-a53b-e75f38dd1e82)
**View Article Page**:
![image](https://github.com/johnsonduong/eng-intern-assessment-rails/assets/71087545/146b1a84-0370-4ae6-8b66-6c0766004e0b)
**Searching Articles**:
![image](https://github.com/johnsonduong/eng-intern-assessment-rails/assets/71087545/ed44277b-5009-453f-97f3-233158002e5a)
**Form Input Validation**:
![image](https://github.com/johnsonduong/eng-intern-assessment-rails/assets/71087545/cd59eaa5-c5a1-4c6c-aa80-b2ecfc6b7ae8)
**Example Success Feedback**:
![image](https://github.com/johnsonduong/eng-intern-assessment-rails/assets/71087545/5c9e5efd-9c11-44e9-b2cb-b65e328d12b3)

## Additional Notes
- The project README.md specifies to use `rspec` for testing, however, the project starter code is using `Minitest` and looking at the commit history - it seems like `rspec` was meant to be removed. With that said, I assumed testing would be done using `Minitest`.
- Added an optional development gem to improve the developer experience for future devs that work out of this repository. The dependency is [solargraph](https://solargraph.org/) which provides Rails intellisense to the code editor.

## Possible Future Improvements
As this application scales in the production environment, it is important to consider performance enhancements. Below is a list of potential improvements (this is only a small subset of the many potential improvements!):

1. **Database Optimization**: With the growing collection of articles, query speeds might slow down. Implementing indexes on fields such as `title` and `author`, along with implementing caching, possibly with tools like Redis, can help reduce database load and improve response times. 

2. **API Development**: Developing an API could greatly expand the app's capabilities, facilitating integration with other platforms and supporting future growth.

3. **Performance Monitoring**: Additionally, using Datadog for performance monitoring could provide real-time insights into the application's performance, combining efficient operation with the ability to quickly identify performance bottlenecks.

## Thanks for Reviewing!
<img src="https://media.tenor.com/e-LsbnNHQ5cAAAAd/catjam-cat-dancing.gif" alt="Dancing Cat" width="200">
