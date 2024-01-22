# Article Management System

Heres a video the goes over the MVC architecture in this application: https://youtu.be/H0J4y3z60xs?si=KXAIT3WepRyBMUcT

## Overview
This Article Management System is a web application built with Ruby on Rails. It allows users to perform Create, Read, Update, and Delete (CRUD) operations on articles. Additionally, it features a search capability to quickly find articles based on their titles or content.

## Features

- **Create Articles**: Users can add new articles to the system, providing a title and content.
- **Read Articles**: Users can view the list of all articles and read individual articles.
- **Update Articles**: Existing articles can be edited, allowing changes to their title and content.
- **Delete Articles**: Users can remove articles from the system.
- **Search Articles**: A search function enables users to find articles by keywords in their titles or content.

## Getting Started

### Prerequisites
- Ruby
- Rails
- SQLite (for development)

### Installation
1. **Clone the repository:**
   ```bash
   git clone https://your-repository-url.git
   cd your-repository-name

2. **Install Ruby and rails:**
   Ensure Ruby and Rails are installed on your system.

3. **Install dependencies:**
    bundle install

4. **Setup the database:**
    ```bash
    rails db:create
    rails db:migrate

5. **Start the rails server:**
    ```bash
    rails server

5. **Visit the application:**
    Open http://localhost:3000 in your web browser.

6. **Test the Application:**
    ```bash
    rails test
## Usage Instructions

- Access the homepage to view all articles.
- Use the 'New Article' button to create articles.
- Select an article to read, edit, or delete.
- Utilize the search bar to find articles.
