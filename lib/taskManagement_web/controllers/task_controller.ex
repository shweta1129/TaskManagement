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

   # GET specific task for specidifc user
  def show(conn, %{"user_id" => user_id, "task_id" => task_id}) do
    case Accounts.get_task_for_user(user_id, task_id) do
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Task not found"})

      task ->
        json(conn, %{task: task})
    end
  end

  # update speicif task for user
  def update(conn, %{"user_id" => user_id, "task_id" => task_id, "task" => task_params}) do
    with task when not is_nil(task) <- Accounts.get_task_for_user(user_id, task_id),
         {:ok, updated_task} <- Accounts.update_task(task, task_params) do
      conn
      |> put_status(:ok)
      |> json(%{message: "Task updated successfully", task: updated_task})
    else
      nil ->
        conn
        |> put_status(:not_found)
        |> json(%{error: "Task not found"})

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> put_view(TaskManagementWeb.ChangesetView)
        |> render("error.json", changeset: changeset)
    end
  end
  
# DELETE /users/:user_id/tasks/:task_id
def delete(conn, %{"user_id" => user_id, "task_id" => task_id}) do
  case Accounts.get_task_for_user(user_id, task_id) do
    nil ->
      conn
      |> put_status(:not_found)
      |> json(%{error: "Task not found"})

    task ->
      case Accounts.delete_task(task) do
        {:ok, _} ->
          conn
           |> put_status(:ok)
           |> json(%{message: "Task deleted successfully"})

        {:error, reason} ->
          conn
          |> put_status(:internal_server_error)
          |> json(%{error: "Failed to delete task", reason: reason})
      end
  end
end

end
