# Shopify Backend Engineer Internship

Hi all! I am Lichuan(Isabella) Yang, and this is the submission for Shopify's 2024 summer backend engineering internship

- [Project Overview](#project-overview)
- [Env setup](#env-setup)
- [Feature(APIs) details](#featureapis-details)

## Project Overview

The Shopify Encyclopedia was developed using Ruby on Rails (Version. 2.7.6), following the MVC architecture. CRUD and search function were implemented. All the tests passed.

Most of the effort was put into the backend development:

- Understandable and matainable code
- Robust error handling
- Comprehensive unit tests to ensure high code coverage

## Env setup

1. Ensure Ruby and Rails are installed in the machine(If not, following this [page](https://github.com/rbenv/rbenv) to have everything setup)
2. `git clone` the repo to local machine
3. Run `bundle install` to install all the dependencies
4. Run `rails db:migrate`
5. Run `rails server`
6. Go to http://localhost:3000 to view the UI
7. To run tests, run `rails test`

## Feature(APIs) details
|HTTP Verb   |  Path | Description|
|---|---| ---|
|GET   |  /articles | Get the listing page of all the articles |
|GET   |  /articles/:id | Get the detail page of the target article specified by the id |
|POST   |   /articles | Create a new article with the inputs as parameters (title, content, author, date)|
|PATCH   | /articles/:id  | Update the information of the target article specified by the id   |
|DELETE   |  /articles/:id | Delete the target article specified by the id |
|GET   |  /articles?search=:string | Display articles that has either "title" or "content" matching the search bar input |
|GET   |  /articles?clear=Clear| Clear the input in the search bar and return full listing of the articles|