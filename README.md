# Shopify Intern Encyclopedia

## Project Overview
The Rails application serves as an Encyclopedia, designed to be an informative and interactive platform. Users have the ability to create, view, edit, and delete articles. The application also includes a search functionality to help users find relevant articles based on their search queries.
![Landing Page](/public/home.png)

## Demo
Unlisted Video: https://www.youtube.com/watch?v=4Y8WtTw-dZI

## Test Results
![Main Tests](/public/tests.png)

![User Tests](/public/user_tests.png)

## Codebase Updates

### Key Updates:
1. **Authentication/Sessions**: Implemented using [Devise](https://github.com/heartcombo/devise) for secure user authentication and session management.
2. **Article CRUD Behavior**: Developed the Create, Read, Update, and Delete (CRUD) functionalities for articles, allowing users to interact with article records effectively.
3. **Search Functionality**: Integrated a search bar that queries article titles and content, enabling users to find relevant articles based on keywords.
4. **User/Auth Tests**: Implemented comprehensive tests for the User model to ensure data integrity and validation.
5. **Added Article Tests**: Implemented additional article and article controller tests for completeness.


### Detailed Overview:
- **Authentication/Sessions**: Leveraged Devise, a flexible authentication solution for Rails, ensuring secure and efficient handling of user sessions and authentication processes. Validations maintain data integrity for registrations.
- **Article Management**: 
   - Created robust forms and views to handle the creation and editing of articles.
   - Ensured a smooth user experience by implementing intuitive navigation between article actions (create, view, edit, delete).
   - Included validations to maintain data integrity and provide user feedback.
- **Search Bar Implementation**:
   - Incorporated a search feature that filters articles based on user input.
   - Optimized query handling to fetch relevant articles by matching keywords against article titles and content.
- **User-related Tests**:
   - The newly added tests cover a range of validations for the User model, ensuring that the user data is correctly validated before saving to the database. 
   - These tests check for the presence of essential fields such as email, and password. 
   - They also enforce business rules such as unique emails and minimum password length. The tests help maintain the integrity of the user-related functionalities

### Getting Started:
- Clone the repository to your local development environment.

- Install the necessary dependencies by running bundle install in the project directory.

- Seed the DB with some articles by running: bin/rails db:create, bin/rails db:migrate, bin/rails db:seed

- Start the server up by using: rails server

- Open a web browser and navigate to http://localhost:3000 to view the application.

