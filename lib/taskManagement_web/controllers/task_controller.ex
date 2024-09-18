defmodule TaskManagementWeb.TaskController do
  use TaskManagementWeb, :controller
  alias TaskManagement.Accounts

  action_fallback TaskManagementWeb.FallbackController

  # api to create task for a user
  def create(conn, %{"user_id" => user_id, "task" => task_params}) do
    task_params = Map.put(task_params, "user_id", user_id)

    case Accounts.create_task(task_params) do
      {:ok, task} ->
        conn
        |> put_status(:created)
        |> json(%{message: "Task created successfully", task: task})

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> put_view(TaskManagementWeb.ChangesetView)
        |> render("error.json", changeset: changeset)
    end
  end

    # GET task with userid
  def index(conn, %{"user_id" => user_id}) do
    tasks = Accounts.get_tasks_for_user(user_id)
    json(conn, %{tasks: tasks})
  end
end
