defmodule TaskManagementWeb.UserController do
  use TaskManagementWeb, :controller
  alias TaskManagement.Accounts

  action_fallback TaskManagementWeb.FallbackController

  # create users
  def create(conn, %{"user" => user_params}) do
    IO.inspect(user_params, label: "Received user_params")

    case Accounts.create_user(user_params) do
      {:ok, user} ->
        IO.inspect(user, label: "Created user")
        conn
        |> put_status(:created)
        |> json(%{message: "User created successfully", user: user})

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> put_view(TaskManagementWeb.ChangesetView)
        |> render("error.json", changeset: changeset)
      end
      end

        # get all users
  def index(conn, _params) do
    users = Accounts.list_users()
    json(conn, %{users: users})   
  end

end
