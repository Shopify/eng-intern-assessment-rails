# Encyclofy - Neema Sadry

## Features
- Styled using Tailwind CSS via [Play CDN](https://tailwindcss.com/docs/installation/play-cdn)
    - *Note: The Play CDN is designed for development purposes only, and is not the best choice for production.*
- Added `faker` gem to generate data in `seeds.rb` during development
- Added `better_errors` and `binding_of_caller` gems to improve debugging in development environment

## Learning Experience & Accomplishments
1) Learned how to set up Tailwind CSS 3 different ways:
   1) Initially, I tried [installing Tailwind CSS with Ruby on Rails as suggested in the docs](https://tailwindcss.com/docs/guides/ruby-on-rails).
      - However, I kept running into errors when trying to start my build process with the `bin/dev` command.
      - This error had something to do with running either the [`overmind` package](https://github.com/DarthSim/overmind) or the [`foreman` gem](https://rubygems.org/gems/foreman).
   2) To get the development process underway quickly, I just [added Tailwind CSS via Play CDN](https://tailwindcss.com/docs/installation/play-cdn), which worked for the majority of my development needs for this project. However, there are some caveats consider:
      - As stated ***just before the first step*** in the documentation:
        > The Play CDN is designed for development purposes only, and is not the best choice for production.
        
        While we aren't deploying this project to production, I wanted to assume that we would. After all, that is the ultimate goal of developing *any* web app, regardless of the tech stack being used.
      - There were technical difficulties when I attempted to add more robust solutions. For example, adding the [`pagy` gem](https://github.com/ddnexus/pagy) for paginating all records listed from the `articles` table. Specifically, I was not able to easily style the contents rendered from [the `pagy_nav` helpers](https://ddnexus.github.io/pagy/docs/extras/tailwind/#style-2).
   3) Towards the end of my project, I remembered from past experience that there was *another* way to install Tailwind CSS! After a quick search, I found [the solution using the `cssbundling-rails` gem](https://stackoverflow.com/questions/71640507/how-to-import-tailwind-plugin-in-rails-7). This solution worked perfectly :thumbsup:
2) While adding Tailwind CSS was my goal, **I would *only* proceed doing so** if I could augment the `bin/setup` script to easily install *all* additional dependencies. My decision for this came primarily out of respect and consideration for the individual(s) reviewing my application and technical assessment; providing a streamlined and pain-free way to setup my project on their development machines is something anyone would appreciate :innocent:
3) Used `asdf` to add `.tool-versions` file to project directory, which allowed me to set the ***`local`*** `ruby` version to `2.7.6` while retaining the ***`global`*** version to `3.3.0`.
4) 

## Technical Challenges


## Screenshots



# Technical Instructions - Shopify
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
