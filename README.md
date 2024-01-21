# Shopify Backend Engineering Internship - Technical Challenge

My name is Christopher Fong, and this is my submission for Shopify's 2024 summer backend engineering internship

# Project Description

This project was built using Ruby on Rails (Ruby 2.7.6), and contains a backend service for an encyclopedia application. The project follows the MVC architecture.

# How to install and run

1. Clone the repo into a local folder
2. Run `bundle install` (Ensure that you have the necessary dependencies installed: [Ruby](https://www.ruby-lang.org/en/documentation/installation/), [Rails](https://guides.rubyonrails.org/getting_started.html#creating-a-new-rails-project-installing-rails))
   I recommend using a version manager such as [rbenv](https://github.com/rbenv/rbenv)

3. Run `rails db:migrate`
4. Run `rails server`, the application's interface should now be visible on http://localhost:3000

# Feature Overview & Pirmary Changes

The application implements CRUD and search endpoints for various articles. Below is a table of the endpoints and examples for their usage

| HTTP Verb | Path                 | Controller#Action  | Used for                                                                                                                 |
| --------- | -------------------- | ------------------ | ------------------------------------------------------------------------------------------------------------------------ |
| GET       | `/articles`          | `articles#index`   | Display a list of all articles                                                                                           |
| GET       | `/articles/new`      | `articles#new`     | Return an HTML form for creating a new article                                                                           |
| POST      | `/articles`          | `articles#create`  | Create a new article                                                                                                     |
| GET       | `/articles/:id`      | `articles#show`    | Display a specific article                                                                                               |
| GET       | `/articles/:id/edit` | `articles#edit`    | Return an HTML form for editing an article                                                                               |
| PATCH/PUT | `/articles/:id`      | `articles#update`  | Update a specific article                                                                                                |
| DELETE    | `/articles/:id`      | `articles#destroy` | Delete a specific article                                                                                                |
| GET       | `/search/params`     | `articles#search`  | Search the encyclopedia for related articles. Results are matched based on likeness to the title, author, and/or content |

### Additional Changes

Beyond passing the origina test cases, I also extended the amount of unit tests to cover different cases such as search entries with leading/trailing whitespace, and creational tests for invalid inputs.

I also created a test suite for the `article_controller.rb`, in which I ensured that most of the endpoints executed the correct behaviour, and returned the correct response codes.

### Code style

I primarily followed the style used in the different tutorials at https://guides.rubyonrails.org/. I did not add excessive documentation because I prefer that code is self-documenting, such that the logical flow/structure and naming conventions are sufficient to inform readers/reviewers. I added a few comments to document certain design choices.

Here are some resources that may be helpful during your internship project:

- [Ruby on Rails Guides](https://guides.rubyonrails.org/) - Comprehensive guides on Ruby on Rails, covering various aspects of web application development.

- [Ruby Style Guide](https://rubystyle.guide/) - A community-driven Ruby coding style guide to ensure consistent and readable code.

- [Git Documentation](https://git-scm.com/doc) - Official documentation for Git, the version control system used in this project.

# What I would improve/change for the future

Currently, the project is relatively barebones in that it merely implements basic CRUD operations and a straightforward search query. How I would improve/extend this project for the future is to:

- **Extend the search functionality**: The search endpoint could be improved by searching each keyword in the entry. For example, a search parameter "Article Bob" would search Bob and Article individually, and return all distinct results.

- **Flesh out the client**: The view layer leaves certain things to be desired. Adding some styling or implementing a separate client-side would improve the user experience and enforce decoupling.

- **Extend Testing Suite**: The project could certainly use additional integration tests to cover more complex behaviours and patterns that unit tests may not catch.

- **Upgrade Language Version**: Unfortunately, Ruby 2.7.6 is an older version of the language and has reached end of support for many tools such as the official Shopify LSP. There are a number of breaking changes according to the [Release Notes](https://www.ruby-lang.org/en/news/2020/12/25/ruby-3-0-0-released/), but none that seem to affect the project significantly in its current state.

# Final Notes

It was fun developing this project using a language and framework that I had no experience in prior. I enjoyed using Ruby, it was much more straightforward and intuitive than I expected, and had a smooth experience similar to python.

To whoever views this, I would greatly appreciate any feedback/suggestions!

Best, Christopher Fong
