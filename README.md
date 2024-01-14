# Overview
Article application allows for CRUD and search functionality for articles.

A demo video can be found here: [eng-intern-assesment-rails-shahilax.webm](https://github.com/Shopify/eng-intern-assessment-rails/assets/46412618/c146e6b1-a65e-4250-af57-c1327aabfe00)

## Additonal tools/libaries
Addtional tools added include:
- [rspec-rails](https://rspec.info/documentation/6.0/rspec-rails/) for rspec test cases
- [tailwindcss](https://tailwindcss.com/) for UI implemenation

# Testing
Original tests were written in rails default testing framework minitest, but instruction noted that the tests should be locally run using the 'rspec' command. As such the follow steps were taken:
- rspec-rails was installed and setup
- Controller, Model, and System tests were converted into rspec tests


### Rspec
To run the rspec tests, ensure you already run: ```bundle install```. 

Thereafter you can run one of the follow commands:
```
rspec
```

```
bundle exec rspec 
```
This will run all 24 tests, including the system tests.


### Minitest

To run the minitest tests you can run one of the follow commands:
```
rails test
```
```
bundle exec rails test
```
This will execute all tests except for the tests in the system file. To run these tests, you must explicitly state the path to the directory:
```
rails test test/system
```

