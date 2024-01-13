# Encyclopedia - Shopify-Summer-2024 Technical Challenge

This is my submission for Shopfiy's Summer Internship Technical Challenge. This Rails application is an Encyclopedia, which allows users to create, view, edit, and delete articles. The application also provides search functionality to help users find relevant articles. I have also created a user interface that can be used locally to test features.

## CRUD

## Local Installation
### Prerequisites:
- Require Ruby 2.7.6
- Require Ruby 7.1.2
- Require Bundler 2.1.4
- clone [eng-intern-assessment-rails](https://github.com/adarsh-swe/eng-intern-assessment-rails)

### Generate Dev build
1. run `bundle install` to install required gems
2. run `rails db:migrate` to intialize the database
3. run `rails db:seed` to generate seed values for articles that I have included
4. run `rails server` to create a develoepr build of the project
5. Access the app on http://localhost:3000/
6. Access RDoc documenation by opening the `./doc/index.html` file in your browser

## Run Test Cases
With the same prerequisites for local installation as described [above](#local-installation):
1. run `rails test` in the root directory of the repo to run provided test cases

Validated results from test cases:

<img width="500" alt="image" src="https://github.com/adarsh-swe/eng-intern-assessment-rails/assets/59131301/1ba0c32f-2e5f-4310-bc43-66b790f0af5a">

