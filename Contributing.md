# Contributing

### Getting Started

1. Clone [Repository](https://github.com/JDVM/eng-intern-assessment-rails)
2. In the terminal run "bundle install" in the terminal to install gems
3. In the terminal start the application by running "rails s"

### Configuration

1. Ruby: version  3.2.2
2. Rails: 7.1.3

### Dependencies

1. RuboCop LSP
2. Database Cleaner

### Usage

1. To create a new article press the New Article button.
2. After creating a new article it can be edited via the Edit button.
3. To delete an article press the Destroy button.

### Testing

1. Run "rails test" in terminal
2. To run a specific test run "rails test" followed by the file location and test name.
<br> For example: "rails test test/models/article_test.rb -n test 'starts with no articles'"
3. To test see the specific results of a single test run "rails test -v"
