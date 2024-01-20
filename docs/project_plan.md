# eng-intern-assessment-rails
#### By _Ali Rahbar_
___

## Project Overview
The primary objective of this project is to develop a straightforward encyclopedia, assessing the programmer's comprehension of backend development and their capability to fulfill project requirements.

## Scope
By project completion, we aim to deliver a fully functional encyclopedia web application, equipped with CRUD operations, enabling users to Create, Read, Update, and Delete articles.

### Deliverables
1. Article List Page:
   * Display a comprehensive list of all articles.
2. Search Functionality:
   * Implement a search feature to facilitate document exploration.
3. Article Reading Page:
   * Enable users to view articles on a separate page.
4. Document Creation and Editing:
   * Allow users to create new documents and edit existing articles.
5. Deletion Feature:
   * Provide users with the capability to delete articles.

## Testing and Quality Assurance
Testing is crucial for ensuring the functionality of both the software and the database. The following test files will be utilized:
* `connection_test.rb` ==> Tests database Connection
* `articles_controller_test.rb` ==> Tests controller functionality
* `article_test.rb` ==> Tests database functionality 

Note: The `articles.yml` file adds an example record to the database for testing which required modifications to the `article_test.rb` file for proper testing. 

## Documentation
Thorough documentation is essential for code comprehension. The following areas require documentation:
### Ruby files
Add the following block comment at the beginning of each Ruby file:

```Ruby
# File: FileName.rb
# Programmer Name: [Your Name]
# Description: This file contains the implementation of [briefly describe the purpose or functionality of the file].
#              [You can provide additional details about the file here if necessary].
# Date: [Current Date]
#
# Notes:
# - [Any additional notes or considerations related to the file can be mentioned here].
# - [You can use this space to provide context, references, or any important information].
```

### Web Components
Web Component Documentation follows a similar format:

```html
<!-- File: FileName.html.erb -->
<!-- Programmer Name: [Your Name] -->
<!-- Description: This file contains the HTML and ERB code for [briefly describe the purpose or functionality of the file].
                 [You can provide additional details about the file here if necessary]. -->
<!-- Date: [Current Date] -->
<!--
Notes:
- [Any additional notes or considerations related to the file can be mentioned here].
- [You can use this space to provide context, references, or any important information].
-->
```

### Rails Generators
Track used generators in the generator log file in the docs page using the following format:
```Markdown
# Programmer Name: [Your Name]
# Date: [Current Date]
# Description: [Brief description of the purpose of this generator]
# Command Used: [Place the generator command you used here]
___
```