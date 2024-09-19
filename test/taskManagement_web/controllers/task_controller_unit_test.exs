defmodule TaskManagementWeb.TaskControllerTest do
  use TaskManagementWeb.ConnCase, async: true
  alias TaskManagement.Accounts

  @create_user_attrs %{name: "Marie", email: "marie@gmail.com", age: 30}
  @create_task_attrs %{title: "Finish Project", description: "Complete the project by the end of the week.", due_date: "2024-09-24", status: "To Do"}
  @invalid_task_attrs %{title: nil, description: nil, due_date: nil, status: nil}

  describe "POST /users/:user_id/tasks" do
    test "creates a new task for a user and returns 201 status", %{conn: conn} do
      {:ok, user} = Accounts.create_user(@create_user_attrs)
      conn = post(conn, "/api/users/#{user.id}/tasks", task: @create_task_attrs)

      assert %{"message" => "Task created successfully", "task" => task} = json_response(conn, 201)
      assert task["title"] == "Finish Project"
      assert task["description"] == "Complete the project by the end of the week."
      assert task["due_date"] == "2024-09-24"
      assert task["status"] == "To Do"
    end

    test "returns an error when task data is invalid", %{conn: conn} do
      {:ok, user} = Accounts.create_user(@create_user_attrs)
      conn = post(conn, "/api/users/#{user.id}/tasks", task: @invalid_task_attrs)

      assert %{"errors" => _} = json_response(conn, 422)
    end
  end

    describe "GET /users/:user_id/tasks" do
    test "lists all tasks for a user", %{conn: conn} do
      {:ok, user} = Accounts.create_user(@create_user_attrs)
      {:ok, _task} = Accounts.create_task(%{
        title: "Finish Project",
        description: "Complete the project by the end of the week.",
        due_date: "2024-09-24",
        status: "To Do",
        user_id: user.id
      })
      conn = get(conn, "/api/users/#{user.id}/tasks")

      assert %{"tasks" => tasks} = json_response(conn, 200)
      assert length(tasks) == 1
      assert hd(tasks)["title"] == "Finish Project"
    end

    test "returns an empty list when the user has no tasks", %{conn: conn} do
      {:ok, user} = Accounts.create_user(@create_user_attrs)
      conn = get(conn, "/api/users/#{user.id}/tasks")

      assert %{"tasks" => tasks} = json_response(conn, 200)
      assert length(tasks) == 0
    end
  end

    describe "GET /users/:user_id/tasks/:task_id" do
    test "returns a specific task for a user", %{conn: conn} do
      {:ok, user} = Accounts.create_user(@create_user_attrs)
      {:ok, task} = Accounts.create_task(%{
        title: "Finish Project",
        description: "Complete the project by the end of the week.",
        due_date: "2024-09-22",
        status: "To Do",
        user_id: user.id
      })
      conn = get(conn, "/api/users/#{user.id}/tasks/#{task.id}")

      assert %{"task" => returned_task} = json_response(conn, 200)
      assert returned_task["title"] == "Finish Project"
    end

    test "returns a 404 error when the task does not exist for the user", %{conn: conn} do
      {:ok, user} = Accounts.create_user(@create_user_attrs)

      # Use a task ID that does not exist for this user
      non_existent_task_id = -1  # Assuming IDs are positive integers
      conn = get(conn, "/api/users/#{user.id}/tasks/#{non_existent_task_id}")

      assert %{"error" => "Task not found"} = json_response(conn, 404)
    end
  end

end
