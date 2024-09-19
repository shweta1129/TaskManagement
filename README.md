<----------------------------------Task Management API------------------------------------>

This application is built with the Phoenix framework and Ecto. It allows users to create, update, delete, and retrieve tasks. This follows the functional programming principles, such as immutability and pure functions, and uses Phoenix's built-in support for concurrency.

<---------------------------------------Features-------------------------------------------->
User Management: Users can be created and associated with tasks.
Task Management: Users can create, update, delete, and retrieve tasks.
RESTful API: Provides API endpoints to manage tasks for a specific user.
Error Handling: Provides robust error handling with JSON responses.
Functional Programming Principles: The code emphasizes immutability and stateless operations.
Unit and Integration Testing: Ensures that all API functionality is properly tested.


<---------------------------------------API Endpoints-------------------------------------->
Task Endpoints:

POST /users/{user_id}/tasks

Create a new task for a specific user.
Request body include: title, description, due_date, status.

GET /users/{user_id}/tasks

Retrieve all tasks for a specific user.

GET /users/{user_id}/tasks/{task_id}

Retrieve a specific task for a user.

PUT /users/{user_id}/tasks/{task_id}

Update a specific task for a user.

DELETE /users/{user_id}/tasks/{task_id}

Delete a specific task for a user.

<----------------------------------Architecture------------------------------------>
The application follows the MVC (Model-View-Controller) pattern:

Models: Models handles the data schema and validation via Ecto schemas and changesets.
Controllers: They manages the business logic and handle API requests. The controllers call the context layer (Accounts) to interact with the database.
Contexts: It is used to encapsulate the business logic and data access. This manages the interaction with users and tasks.

<-----------------------------Design Decisions------------------------------>

Functional Programming: The code emphasizes immutability and stateless design. Business logic is separated into pure functions to avoid side effects.
Error Handling: Errors are handled at the controller level with clear JSON responses. We avoid using views for error handling, instead returning errors directly from the controller for a simpler design.
Concurrency: Phoenix's concurrency model ensures that requests are handled efficiently, even under high loads.
Separation of Concerns: The Accounts context handles all database interactions, while controllers focus on routing and HTTP logic.
Testing: Unit and integration tests cover the key functionality of the API, ensuring robustness. The test suite includes tests for edge cases like invalid parameters and non-existent resources.

<--------------------------------------Setup Instructions------------------------------------>

Prerequisites
---------------
Elixir and Erlang installed.
Phoenix installed.
SQLite database (SQLite for local development).

1. Clone the Repository

git clone https://github.com/shweta1129/TaskManagement.git
cd taskManagement

2. Install Dependencies

mix deps.get

3. Create and Migrate the Database

mix ecto.create
mix ecto.migrate

4. Run the Tests

mix test

5. Start the Phoenix Server

mix phx.server

6. Access the API The API will be available at http://localhost:4000/api/users/:user_id/tasks. You can use tools like curl or Postman to test the endpoints.


<-------------------------------------Testing------------------------------------------->

The project includes a comprehensive test suite, covering both unit and integration tests for the task and user functionalities.

Run the tests with:  mix test


<--------------------------------Conclusion------------------------------------------>
This project demonstrates how to build a RESTful API in Phoenix while adhering to functional programming principles and clean architecture. It handles common operations like creating, updating, retrieving, and deleting tasks while providing robust error handling and test coverage.






