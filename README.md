# Overview
This article application allows for CRUD and search functionality for articles.

A [demo](https://youtu.be/9w4d724Q11U) video for the primary functionality.

Additional Features demo:
- [Caching ](https://youtu.be/wr0_SgexbAA)
- [Default Value](https://youtu.be/vdr5R92tVRk)

## Additional tools/libraries
- [rspec-rails](https://rspec.info/documentation/6.0/rspec-rails/) for rspec test cases
- [tailwindcss](https://tailwindcss.com/) for UI implementation
- [rubocop](https://docs.rubocop.org/rubocop-rails/) for consistent and readable code that complies with the ruby style guide


# Local Startup
1. Ensure that you have all of the prerequisites
- Ruby 2.7.6+
- Rails 7.1.2+
- SQLite3 3.39.5+

2. Next go to the root directory of the folder and install all gems
```
bundle install
```
3. Next start the rails server
```
rails server
```

- If this command does not work, you can also try:
```
./bin/rails server
```

4. From here you can navigate to ```localhost:3000``` on your browser and... tada!


# Testing
Original tests were written using the default Minitest framework, but instruction noted that the tests should be locally run using the 'rspec' command. As such the following steps were taken:
- rspec-rails was installed and setup
- Controller, Model, and System tests were converted into rspec tests


### Rspec
To run the rspec tests, ensure you already run: ```bundle install```. 

Thereafter you can run one of the following commands:
```
rspec
```

```
bundle exec rspec 
```
This will run all 24 tests, including the system tests.


### Minitest

To run the minitest tests you can run one of the following commands:
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

## Caching
To use (fragment) caching in development mode, you must enable it with the following command:
```
rails dev:cache
```

Further, for an easier experience run the following command to seed mock data into the DB:
```
rake db:seed
```
If you ever want to reset the data you can modify the seed file and rerun ```rails db:seed```

To clean out the database entries, the following command can be used:
```
rake db:reset
```



