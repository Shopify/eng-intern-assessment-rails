# Developed feautres for backend of Shopify's Summer 2024 Internship Application
## Check list of features below:
- [x] Create the Article model, migration, and passed all tests (should have not have use generate model for this,it made instances of the model and I had to delete them manually)
- [x] Create the Article's controller, views (routing was really hard to get right)
- [x] Added search functionality (An area that could be improved upon, for exmaple real time search)
- [x] Styled the views with tailwindcss, (many many stuffreings here to make the app look ok)

## Branches:
- [x] Main branch: contains the final version of the app
- [x] Backend branch: contains the logic of the app (models, controllers, views)
- [x] style branch: contains the styling of the app (tailwindcss)
### I merged the style into the backend branch, and then merged the backend branch into the main branch

## The journey: 

 I faced a lot of truble at the begging of projct, becuase the ruby version of my Mac was 3.1.3 and the version used by Shopify was 2.7.6, so I had to use RVM to switch between versions. This task was not simple!, but after many google searches and stackoverflow questions I was able to do it.

 As I mentioned above, I had to delete the instances of the model that was created by the generate model command, and I had to do it manually, this is the commond that I used.
```bash
rails rake db:reset db:migrate
```
After that, tests were straight forward, and I was able to pass them all.

 Making models and controllers was not hard, but the routing was hard so I did a lot of logging to understand what was going on. I also found a really good command to see all the routes in the app, and it was really helpful.
```bash
rails routes
```
 Searching functionality was mostly logic and simple rail queries. But I did some research on how to make the search bar work in real time, and I found a really good article on how to do it, but I did not have time to implement it. I will leave the link to the article below.
[Real time search](https://webcrunch.com/posts/turbo-charged-real-time-search-ruby-on-rails-7)

 Forms, forms and FORMSSSS!, how to use form and what they do was an important part of this assingment and I learned a lot about them.(P.S. I was very confused about PATCH but I figured it out)

 Safty checks and nets!, I had to make sure that the user does not enter empty strings for the title and content, and I took two differnt approaches, becuase I could not get the instance of the model in the create view. So I used flash messages.

 Styling was the last thing I did, and I used tailwindcss to do it(I love tailwindCSS). As a person with near to zero design skills, I find tailwindcss a godsend and pure joy to use! Even though the process of adding to the ruby on rails was hell, and I've seen that happen with other frameworks too, like SvelteKit.(but right when you think it is never gonna work, it does, so you just have to push through it)
 The error I was getting was this(Still not sure how I fixed it lol):
```bash
Tasks: TOP => assets:precompile => tailwindcss:build
(See full trace by running task with --trace)
```

## My takeaways:
 As a person who has never used ruby on rails, before forking the repo I did a lot of research to get comprehand and get to know the way this framwork works(From what I've seen so far its kinda like a mix of python and php, but I'm not sure).
 Pros: Being MVC, databse integration, and short and fun syntax of ruby. I have exprince making backend APIs with python(fastAPI), GO(GOlang), and NodeJS(Express), and I have to say that ruby on rails is like the Java of backend frameworks, Java makes you do OPP and ruby on rails makes you do MVC, and is desigened to be like that.
 Cons: I did not like <%%> syntax in erb files, but I know there are other ways of integrating ruby with html. Morever sometimes it was tyring trying to follow the MVC pattern all the times for the routing specificaly.

 Overall this task was hard, challenging, and a steping stone to learn ruby on rails! I had a lot of fun doing it, and I hope you like it too!

##### Made with ❤️&coffee by Hamid

## resources:
- [RVM for mac](https://nrogap.medium.com/install-rvm-in-macos-step-by-step-d3b3c236953b)
- [Made to be read by humans ruby on rails docs](https://human-se.github.io/rails-demos-n-deets-2021/)
- [Formatting ruby on rails](https://rubocop.org/)
- [Tailwindcss config](https://tailwindcss.com/docs/guides/ruby-on-rails)
- [A form porblem I had](https://stackoverflow.com/questions/19365809/form-submit-button-only-works-after-reload)
- [Ruby syntax](https://www.tutorialspoint.com/ruby/index.htm)
- [Docs of ruby on rails](https://guides.rubyonrails.org/getting_started.html)
- [API docs of ruby on rails](https://api.rubyonrails.org/)
- [A good series on ruby](https://www.youtube.com/watch?v=9pKLGhh5mrM&t=73s)
----
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

5. Run the tests locally using the rspec command to ensure they are passing.

6. Start working on the goals outlined above, making improvements to the existing tests and adding new tests as needed.

7. Commit your changes regularly and push them to a branch in your forked repository.

8. Once you have completed the project goals, create a pull request to merge your changes into the main repository.

## Resources
Here are some resources that may be helpful during your internship project:

- [Ruby on Rails Guides](https://guides.rubyonrails.org/) - Comprehensive guides on Ruby on Rails, covering various aspects of web application development.

- [Ruby Style Guide](https://rubystyle.guide/) - A community-driven Ruby coding style guide to ensure consistent and readable code.

- [Git Documentation](https://git-scm.com/doc) - Official documentation for Git, the version control system used in this project.
