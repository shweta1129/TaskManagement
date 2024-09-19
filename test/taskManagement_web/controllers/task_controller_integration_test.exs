defmodule TaskManagementWeb.TaskIntegrationTest do
  use TaskManagementWeb.ConnCase, async: true
  alias TaskManagement.Accounts

  @create_user_attrs %{name: "Marie", email: "marie@gmail.com", age: 30}
  @create_task_attrs %{title: "Finish Project", description: "Complete the project by the end of the week.", due_date: "2024-09-24", status: "To Do"}
  @invalid_task_attrs %{title: nil, description: nil, due_date: nil, status: nil}


  describe "Task API Integration" do

    test "creates a new task and then fetches the task list", %{conn: conn} do
      {:ok, user} = Accounts.create_user(@create_user_attrs)
      conn = post(conn, "/api/users/#{user.id}/tasks", task: @create_task_attrs)
      assert %{"message" => "Task created successfully", "task" => _task} = json_response(conn, 201)

      conn = get(conn, "/api/users/#{user.id}/tasks")
      assert %{"tasks" => tasks} = json_response(conn, 200)
      assert length(tasks) == 1
      assert hd(tasks)["title"] == "Finish Project"
    end

    test "handles invalid task creation and verifies user task list is empty", %{conn: conn} do
      {:ok, user} = Accounts.create_user(@create_user_attrs)
      conn = post(conn, "/api/users/#{user.id}/tasks", task: @invalid_task_attrs)
      assert %{"errors" => _} = json_response(conn, 422)

      conn = get(conn, "/api/users/#{user.id}/tasks")
      assert %{"tasks" => tasks} = json_response(conn, 200)
      assert length(tasks) == 0
    end

    test "creates a task and retrieves it using the task ID", %{conn: conn} do
  {:ok, user} = Accounts.create_user(@create_user_attrs)

  task_params = Map.merge(@create_task_attrs, %{user_id: user.id})
  conn = post(conn, "/api/users/#{user.id}/tasks", task: task_params)

  assert %{"message" => "Task created successfully", "task" => task} = json_response(conn, 201)

  conn = get(conn, "/api/users/#{user.id}/tasks/#{task["id"]}")
  assert %{"task" => returned_task} = json_response(conn, 200)

  assert returned_task["id"] == task["id"]
  assert returned_task["title"] == "Finish Project"
    end




  end
end
