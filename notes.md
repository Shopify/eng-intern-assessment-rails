# Goal
- Tests are written. Implement functionality to make them pass. 

# Notes
- docker build -t shopify_project .
    - used to build the docker container. helpful since it has all the dependencies and I don't have to mess around with local stuff.
- bypassing docker stuff for now since the build through an error while launching the image.
- installed rbenv to manage version and set to 2.7.6
- had to add some stuff to my shell loader so that it could work with rbenv
- tests are able to be ran. 
- familiarize myself with the code:
    - models
    - controllers
    - views
- okay well there isn't really that much code. looks pretty empty.
- need to make a model class
    - article
        - methods (search, update, valid, find)
            - update, valid, find are all OOTB. 
        - properties (id, content, date, title, author)
    - created model
    - need to create some methods
        - search
            - should search the title AND the content
- Implement basic CRUD actions on articles in a controller
    - Done
- Create view to see work in the app
    - Done

# Probs
- the route to add a new article doesn't seem to work for some reason. 
    - routes shows POST /articles(.:format)     articles#create
        - seems like it exists in the controller and is registered okay through routes
        - found some stuff the tutorial was missing and added in on the view. (scope, url, local)


# Nice to have
- write some extra tests.
    - returns accurate search results for non-match
    - create articles with some missing required params (title/content)
    - create article with content < min length
    - updates the article content to an invalid content size
    - empty search query returns all results
    - returns accurate search results for non-match
    - returns match with any case results

# References
## Ruby
- https://github.com/rbenv/rbenv?tab=readme-ov-file
- bin/rails test (run all the tests)