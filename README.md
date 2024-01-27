# Shopify Intern Encyclopedia

## Project Overview
The Rails application serves as an Encyclopedia, designed to be an informative and interactive platform. Users have the ability to create, view, edit, and delete articles. The application also includes a search functionality to help users find relevant articles based on their search queries.

## Demo
Unlisted Video: https://www.youtube.com/watch?v=4Y8WtTw-dZI

## Test Results


## Codebase Updates

### Key Updates:
1. **Authentication/Sessions**: Implemented using [Devise](https://github.com/heartcombo/devise) for secure user authentication and session management.
2. **Article CRUD Behavior**: Developed the Create, Read, Update, and Delete (CRUD) functionalities for articles, allowing users to interact with article records effectively.
3. **Search Functionality**: Integrated a search bar that queries article titles and content, enabling users to find relevant articles based on keywords.

### Detailed Overview:
- **Authentication/Sessions**: Leveraged Devise, a flexible authentication solution for Rails, ensuring secure and efficient handling of user sessions and authentication processes. Validations maintain data integrity for registrations.
- **Article Management**: 
   - Created robust forms and views to handle the creation and editing of articles.
   - Ensured a smooth user experience by implementing intuitive navigation between article actions (create, view, edit, delete).
   - Included validations to maintain data integrity and provide user feedback.
- **Search Bar Implementation**:
   - Incorporated a search feature that filters articles based on user input.
   - Optimized query handling to fetch relevant articles by matching keywords against article titles and content.

