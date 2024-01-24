# Encyclofy - Neema Sadry

## Setup :gear:
1) Clone the repo from GitHub on to your local machine
2) Setup the project's dependencies by running the following command from the project's *root* directory:
   ```bash
   bin/setup
   ```
   Outlined below are all the tasks the should happen ***in order***: 
    1) Installs the following: 
       1) All gems listed in `Gemfile`
       2) The `foreman` gem ***globally***
       3) `Yarn` package manager (via `npm`)
       4) Packages listed in `package.json`
    5) Compiles (i.e., `build`) CSS & JS files
    6) Runs the following commands:
       1) [`rails db:prepare`](https://edgeguides.rubyonrails.org/active_record_migrations.html#preparing-the-database)
       2) `rails log:clear` - Truncates all/specified *.log files in log/ to zero bytes
       3) [`rails tmp:clear`](https://guides.rubyonrails.org/command_line.html#bin-rails-tmp)
       3) `rails restart` - Restarts app by touching tmp/restart.txt
3) Start the application using the following command:
   ```bash
   bin/dev
   ```
   This will use [`foreman` (see *Introducing Foreman* blog post)](http://blog.daviddollar.org/2011/05/06/introducing-foreman.html) to run and manage all the processes listed in `Procfile.dev`.
4) Optionally, you can run the following command to run ***all*** tests:
   ```bash
   rails test
   ```

## Features :star2:
- Styled using [Tailwind CSS](https://tailwindcss.com/)
- Pagination via [Pagy](https://github.com/ddnexus/pagy)
- Generate seed data randomly with [Faker](https://github.com/faker-ruby/faker)
- Added [`better_errors` gem](https://github.com/BetterErrors/better_errors) and [`binding_of_caller` gem](https://github.com/banister/binding_of_caller) to improve debugging in `development` environment
- Comprehensive test suite

## Learning Experience & Technical Challenges :man_technologist:

Outlined below are key insights into my learning experiences, technical challenges, and the strategies I used to overcome them:

### Tailwind CSS is great but not necessary :thinking:
  I would only consider adding Tailwind CSS if I was able to:
  1) Provide the reviewer with a simple fallback solution by [using the `Play CDN`](https://tailwindcss.com/docs/installation/play-cdn).
  2) My capability to augment the existing Bash script, `bin/setup`; automate the setup process for reviewer(s) who need to install newly added project dependencies.

My decisions were driven by a genuine sense of respect and consideration for those reviewing my technical assessment. Offering both a friction-free setup process and alternate solution for my reviewer(s) so they can run my project on *their* computer is a gesture that *any* developer would undoubtedly appreciate :innocent:

### Installed Tailwind CSS via *Multiple* Methods :arrows_clockwise:

1) Since the Rails app was already created for us, I was not able to add Tailwind CSS using the `--css=tailwind` flag with the `rails new` command. Therefore, I followed [the installation steps outlined for Ruby on Rails projects](https://tailwindcss.com/docs/guides/ruby-on-rails). However, I kept running into errors when trying to start my `build` process with the `bin/dev` command.
    > *Note: The errors were somehow related to the [`foreman`](https://rubygems.org/gems/foreman) process manager itself.*
2) To expedite development and save time, I opted to [add Tailwind CSS via the Play CDN](https://tailwindcss.com/docs/installation/play-cdn), which satisfied the majority of my development needs throughout this project. However, there are some caveats I considered when making this decision:
  - As stated *just before the first step* in the documentation:
    > The Play CDN is designed for development purposes only, and is not the best choice for production.

    Despite not having to deploy to production, I find it beneficial to operate under the assumption that we will. After all, the ultimate goal of developing any web app, regardless of the tech stack, is to prepare it for production :wink:
  - Technical difficulties arised when I attempted to add more robust solutions. For example, adding the [`pagy` gem](https://github.com/ddnexus/pagy) for paginating results on the `articles#index` and `search#index` views. 
    - *Note:  It was difficult to style the pagination nav bar rendered from [the `pagy_nav` helpers](https://ddnexus.github.io/pagy/docs/extras/tailwind/#style-2).*

3) Towards the end of my project, ***I remembered from past experience*** that there was ***anothe**r* way to install Tailwind CSS! After a quick search, I found my [previous solution](https://stackoverflow.com/questions/71640507/how-to-import-tailwind-plugin-in-rails-7), which utilized the [`cssbundling-rails` gem](https://github.com/rails/cssbundling-rails). Fortunately, this solution worked perfectly! :partying_face:

### Implementing *Basic* Search Functionality :mag:

Given my constant use of search engines in my other web development projects, (ex. [Meilisearch](https://www.meilisearch.com/) via the [`meilisearch-rails` gem](https://github.com/meilisearch/meilisearch-rails) or [ElasticSearch](https://www.elastic.co/elasticsearch)/[OpenSearch](https://opensearch.org/platform/search/index.html) via the [`searchkick` gem](https://rubygems.org/gems/searchkick)), it was refreshing to implement a *basic* search method using just a raw `SQL` statement.

### Utilizing `asdf` Version Manager :card_index_dividers:
I noticed from the beginning that the project used Ruby 2.x (**not** Ruby 3.x). Because I already had `asdf` setup on my Mac, I just had to run the following command:
   ```bash
   asdf install ruby 2.7.6
   ```
   Afterwards, I added a `.tool-versions` file to the project's root directory, and set the version to `ruby 2.7.6`. This way, I could still use `ruby 3.3.0` everywhere else on my machine :grin:

### :heavy_exclamation_mark: Embracing *Self-Awareness* and *Honesty* to Identify Areas for Improvement :hammer_and_wrench:
 Given how I often feel the lack of discipline when I try to incorporate [Test-Driven Development (TDD)](https://wiki.c2.com/?TestDrivenDevelopment) principles into my workflow, I took it upon myself to reinforce and expand upon the fundamentals I already possessed for [testing rails applications](https://edgeguides.rubyonrails.org/testing.html) by reading [interesting](https://thoughtbot.com/blog/how-we-test-rails-applications) [blog](https://www.mintbit.com/blog/best-practices-for-testing-ruby-on-rails-applications-unit-testing-integration-testing-and-more) [posts](https://blog.railwaymen.org/rails-tests-ruby-on-rails-apps), and watching screencasts on [GoRails](https://gorails.com/), [Drifting Ruby](https://www.driftingruby.com/episodes), or YouTube.

   Ironically, despite having the best intentions, this put me in a *self-imposed **time crunch***; I had to write the majority of my tests *after* completing substantial portions of the application. 
   
   Additionally, I am optimistic and confident abilities to swiftly integrate TDD principles into my development workflow considering the notable progress I achieved during [my previous internship experience at InfluxData](https://www.influxdata.com/blog/meet-influxdata-summer-2022-interns/#heading4). Furthermore, I would welcome the opportunity to discuss these experiences in greater detail during subsequent interviews!

> [!IMPORTANT]
> **I am *eager to optimize and refine every facet* of my existing development workflow** through my role as a Backend Engineering Intern at Shopify. One of my primary objectives is to foster strong engineering habits and practices, particularly by integrating Test-Driven Development (TDD) and/or Behavior-Driven Development (BDD).
   
<br>

# Screenshots :camera_flash:

For your convenience, I have provided several screenshots to facilitate the evaluation of my project. Furthermore, all screenshots can viewed in the [three open Issues](https://github.com/neemasadry/eng-intern-assessment-rails/issues) if they are not displaying here for any reason.

## Article Actions - Encyclofy - Google Chrome :desktop_computer:
![Root page of Encyclofy app running with bin-dev - Google Chrome - Neema Sadry](https://github.com/neemasadry/eng-intern-assessment-rails/assets/78980520/c25c096b-ae35-4623-aa3b-e68114c379dc)
*Root page of Encyclofy app running with **`bin/dev`***

![Show Article - Encyclofy Google Chrome - Neema Sadry](https://github.com/neemasadry/eng-intern-assessment-rails/assets/78980520/5172e190-b14e-44fc-b67d-205ab4159e6a)
*Show Article*

![New Article - Encyclofy Google Chrome - Neema Sadry](https://github.com/neemasadry/eng-intern-assessment-rails/assets/78980520/2c5d2bea-6ba8-4d4d-ab5c-58b1f55a201f)
*New Article*

![Create Article - Encyclofy Google Chrome - Neema Sadry](https://github.com/neemasadry/eng-intern-assessment-rails/assets/78980520/20c21c0e-d707-4386-8c22-2b413f22e17b)
*Create Article*

![Edit Article - Encyclofy Google Chrome - Neema Sadry](https://github.com/neemasadry/eng-intern-assessment-rails/assets/78980520/79040bac-c0b1-47a1-9cf5-be71ad8a587c)
*Edit Article*

![Update Article - Encyclofy Google Chrome - Neema Sadry](https://github.com/neemasadry/eng-intern-assessment-rails/assets/78980520/c8d7a7d3-e4e1-4188-99e6-4aaefc06ac8a)
*Update Article*

![Last Page with Latest Article - Encyclofy Google Chrome - Neema Sadry](https://github.com/neemasadry/eng-intern-assessment-rails/assets/78980520/9bea068f-5dd7-444c-90c4-52066b6f6ffe)
*Last Page with Latest Article*

![Delete Modal - Encyclofy Google Chrome - Neema Sadry](https://github.com/neemasadry/eng-intern-assessment-rails/assets/78980520/65afda2d-664d-410c-b875-dc2f57442b55)
*Delete Modal*

![Delete Article - Encyclofy Google Chrome - Neema Sadry](https://github.com/neemasadry/eng-intern-assessment-rails/assets/78980520/7c755993-0c44-43bf-9c6c-0125a7b609d7)
*Delete Article*

## Search Results Index - Encyclofy - Google Chrome :desktop_computer:
![Index of Search Results for _Article_ - Encyclofy Google Chrome - Neema Sadry](https://github.com/neemasadry/eng-intern-assessment-rails/assets/78980520/bae57ab4-7b82-44db-abaf-a82cd7138b9b)
*Index of Search Results for **Article** Term*

![Redirecting Invalid Search - Encyclofy Google Chrome - Neema Sadry](https://github.com/neemasadry/eng-intern-assessment-rails/assets/78980520/3af03bd0-0c87-4cbb-baee-fc8d1521e569)
*Redirecting Invalid Search Term(s)*

## Process Logs & Output - iTerm2 :ledger:
![Working bin-setup command on iTerm2 - Neema Sadry](https://github.com/neemasadry/eng-intern-assessment-rails/assets/78980520/8cb242e7-a80b-4829-849e-296f7208f63a)
*Working **`bin/setup`** command on iTerm2*

![Rails app running with bin-dev command - iTerm2 - Neema Sadry](https://github.com/neemasadry/eng-intern-assessment-rails/assets/78980520/eba8608b-d8d8-43dd-9819-8d83abce948d)
*Rails app running with **`bin/dev`** command*

![Passing Expanded Test Suite - iTerm2 - Neema Sadry](https://github.com/neemasadry/eng-intern-assessment-rails/assets/78980520/66d7f669-5bd5-40b1-b76a-73845842fe12)
*Passing Expanded Test Suite Successfully*

<br>
<br>

# Shopify

#### Technical Assessment for *Backend* Engineering Internship Application at Shopify over Summer 2024.

## Technical Instructions
1. Fork this repo to your local Github account.
2. Create a new branch to complete all your work in.
3. Test your work using the provided tests
4. Create a Pull Request against the Shopify Main branch when you're done and all tests are passing

## Project Overview
The Rails application you will be working on is an Encyclopedia, which allows users to create, view, edit, and delete articles. The application also provides search functionality to help users find relevant articles. Be sure to implement basic CRUD actions on articles. Your task is to implement these features as well as write the code that makes the tests pass.

## Project Goals
The main goal of this internship project is to implement the functionality required to make the existing tests pass. The provided tests cover various aspects of the application, including creating and viewing articles, editing and updating articles, deleting articles, and searching for articles. Along with completing the tests, be sure to implement all basic CRUD actions on your articles on a controller and create views to see your work in the app.

### Your specific goals for this project are as follows:

1. Review Existing Tests: Start by reviewing the existing tests provided in the `article_test.rb` file located in the `test/models` directory. Understand the requirements and expectations of each test.

2. Implement Functionality: Write the code necessary to make the existing tests pass. This involves implementing the required actions and logic in the models, controllers, and views to fulfill the specified requirements. Also be sure to implement basic CRUD actions and demonstrate proper MVC principals.

3. Ensure Code Quality: Write clean, well-structured, and maintainable code. Follow best practices and adhere to the Ruby on Rails conventions. Pay attention to code readability, modularity, and performance.

4. Test Your Code: After implementing the functionality, run the tests to ensure that they pass successfully. Fix any failures or errors that occur and retest until all tests pass.

5. Code Documentation: Document your code by adding comments and explanatory notes where necessary. This will help other developers understand your implementation and make future maintenance easier.

6. Version Control: Use Git for version control. Commit your changes regularly and push them to a branch in your forked repository.

7. Create a Pull Request: Once you have completed the project goals, create a **pull request** to merge your changes into the `main` repository. Provide a clear description of the changes made and any relevant information for the code review.

## Getting Started
To get started with this project, follow these steps:

1. Clone the repository to your local development environment.

2. Install the necessary dependencies by running bundle install in the project directory.

3. Familiarize yourself with the existing codebase, including the models, controllers, and views.

4. Review the existing tests in the `article_test.rb` file and understand their purpose and functionality.

5. Run the tests locally to ensure they are passing.

6. Start working on the goals outlined above, making improvements to the existing tests and adding new tests as needed.

7. Commit your changes regularly and push them to a branch in your forked repository.

8. Once you have completed the project goals, create a pull request to merge your changes into the main repository.

## Resources
Here are some resources that may be helpful during your internship project:

- [Ruby on Rails Guides](https://guides.rubyonrails.org/) - Comprehensive guides on Ruby on Rails, covering various aspects of web application development.

- [Ruby Style Guide](https://rubystyle.guide/) - A community-driven Ruby coding style guide to ensure consistent and readable code.

- [Git Documentation](https://git-scm.com/doc) - Official documentation for Git, the version control system used in this project.
