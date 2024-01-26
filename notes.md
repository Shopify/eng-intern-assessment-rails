# Goal
- Tests are written. Implement functionality to make them pass. 
# Distilled To-Dos
- 

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
        - properties (id, content, date, title, author)
    - created model
    - need to create some methods
        - search
            - should search the title AND the content

# References
## Ruby
- https://github.com/rbenv/rbenv?tab=readme-ov-file
- bin/rails test (run all the tests)