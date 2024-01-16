## Aim
This change aims to modify the article encyclopedia to add user-friendly functions and a search feature. It does this by implementing CRUD actions/MVC principles.

## Usage
To run this, first bundle install to ensure all dependencies and packages are installed. Then, `bin/rails server` to run the server and view it on http://localhost:3000/. Should you run into database migration errors (like I did), `rake db:drop db:create db:migrate`.

## Testing
To execute the tests that were provided in the original problem statement, run `bin/rails test`. This will test the functionality of the application.
 
## Summary
The article encyclopedia allows users to add, delete, edit, view, and search articles. It was created with Ruby on Rails and additional styling was added using Bootstrap CSS. Below are some examples of the encyclopedia:

In the first screenshot, the user is at the homepage where they can choose to search for an article, click on the title of an article to view/open it, create/delete a new article, or view all articles (default):

<img width="1440" alt="Screenshot 2024-01-15 at 9 20 20 PM" src="https://github.com/a3shoaib/eng-intern-assessment-rails/assets/112360617/e2262382-35c5-4043-9091-d83cd0ee59e1">

In the next screenshot, a user can create a new article by clicking "Create Article", shown in the previous screenshot. Parameters are checked to make sure valid data is entered:

<img width="1440" alt="Screenshot 2024-01-15 at 9 12 03 PM" src="https://github.com/a3shoaib/eng-intern-assessment-rails/assets/112360617/514c2c0f-3c9a-4c0f-a9d2-534c2c7890b8">

When the user creates the article, they are shown the article and can edit, delete, or return to the homepage:

<img width="1438" alt="Screenshot 2024-01-15 at 9 12 23 PM" src="https://github.com/a3shoaib/eng-intern-assessment-rails/assets/112360617/f678e65f-1be3-4ad7-a359-a9b8eb709bcf">


