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

end
