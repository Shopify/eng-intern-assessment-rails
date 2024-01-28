What was requested: 

Review Existing Tests: Start by reviewing the existing tests provided in the article_test.rb file located in the test/models directory. Understand the requirements and expectations of each test.

Implement Functionality: Write the code necessary to make the existing tests pass. This involves implementing the required actions and logic in the models, controllers, and views to fulfill the specified requirements. Also be sure to implement basic CRUD actions and demonstrate proper MVC principals.

Ensure Code Quality: Write clean, well-structured, and maintainable code. Follow best practices and adhere to the Ruby on Rails conventions. Pay attention to code readability, modularity, and performance.

Test Your Code: After implementing the functionality, run the tests to ensure that they pass successfully. Fix any failures or errors that occur and retest until all tests pass.

Code Documentation: Document your code by adding comments and explanatory notes where necessary. This will help other developers understand your implementation and make future maintenance easier.

Version Control: Use Git for version control. Commit your changes regularly and push them to a branch in your forked repository.

Create a Pull Request: Once you have completed the project goals, create a pull request to merge your changes into the main repository. Provide a clear description of the changes made and any relevant information for the code review.

What was completed
Basic CRUD actions were implemented.
Created necessary routes for the CRUD actions to be accessible.
Created a simple frontend.
Created a model for the articles, including validations.
Added additional unit tests.
Added integration tests.
Added system tests.
All tests pass on my system.
Added comments for maintenance and readability
Committed regularly.


Before launching or testing:
    $ bundle install
    $ rake db:create
    $ rake db:migrate

    or

    $ bundle install
    $ rails db:create
    $ rails db:migrate

How to launch:

    $ rails server
    https://localhost:3000/
How to test:
    $ rails test

NOTE: One might have issues with the ruby/rails/bundle version. I personally used rbenv to solve these issues without changing any code; rbenv allowed me to change to the necessary version of ruby used in this project.
