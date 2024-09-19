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





  end
end
