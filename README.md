# Encyclopedia - Shopify-Summer-2024 Technical Challenge

This is my submission for Shopfiy's Summer Internship Technical Challenge. This Rails application is an Encyclopedia, which allows users to create, view, edit, and delete articles. The application also provides search functionality to help users find relevant articles. I have also created a user interface that can be used locally to test features.


For easy testing and demo, I hosted this app on heroku, and can be found here: https://adarsh-shopify-challenge-76faef82d109.herokuapp.com/

In order to host the website, I had to switch from sqlite3 to postgreSQL since sqlite3 is not compatible with heroku. As such, I have created a seperate prod branch with these changes so that it does not interfere with the dev environment of whoever is testing the local version of this app. The local version given in this branch has the original sqllite3 database while the production build is from the new branch and uses prostgreSQL. As a result, I was able to host the app while maintaining the origninal environment for whoever tests the app locally.

## Contents
1. [Usage](#usage)
2. [Local Installation](#local-installation)
3. [Run Test Cases](#run-test-cases)
4. [Additional features](#additional-features)
5. [Reflection](#reflection)

## Usage
To easily test the app, please visit: https://adarsh-shopify-challenge-76faef82d109.herokuapp.com/

Searching for articles is done by checking for similar search key in all article titles, authors, and content. Appropriate articles are then returned.

CRUD actions for articles in the encyclopedia: 
| Action | Description | 
|----------|----------|
| Create | Accepts title (string), content (text), author (string), date (Date) parameters to create a new article. Title and content fields are mandatory, and error messages are shown if they are not included. Author uses 'unkown' as default input and date uses today's date as default input. |
| Read | Returns relevant articles based on search key, list all, or by id. | 
| Update | Accepts title (string), content (text), author (string), date (Date) parameters to update exisiting an article found by id. Title and content fields are mandatory, and error messages are shown if they are not included. Author uses 'unkown' as default input and date uses today's date as default input. | 
| Delete | Deletes specified article by id | 

All of these actions are implemented as methods in the articles controller (`app/controllers/articles_controller.rb`). Each CRUD operation has a corresponding UI component that performs the action.

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

## Additional features
1. Created a clean UI and hosted it (https://adarsh-shopify-challenge-76faef82d109.herokuapp.com/)
   * added form validation
   * used bootstrap for styling
3. Created Rdoc documentation using rdoc specific comments in my code (open the `./doc/index.html` file in your browser)
4. Added rails logging using Rails.logger in my controllers
5. Included seed data to facilitate easier testing

## Reflection
### Biggest Challenges
1. This was my first time working with ruby on rails and there was a learning curve that had to be overcome
   * setting up the dev environment was very complicated
2. Adding the search functionality was tricky, and since I was not familiar with rails built in methods, I had to research a bit to develop a solution
3. Hosting ruby on rails apps on Heroku requires a postgreSQL database in production but we were given sqlite3. Find my workaround [here](#encyclopedia---shopify-summer-2024-technical-challenge)

### Key takeaways
1. Persistence - I faced many blockers with the project, mostly related to environment setup. Despite some frustrating moments, this app taught me to keep going.
2. Ruby on Rails - Having never worked with ruby on rails before, this project gave me a reason to learn and use it. I noticed many similarities between rails and node.

