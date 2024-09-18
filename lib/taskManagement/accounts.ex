defmodule TaskManagement.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias TaskManagement.Repo

  alias TaskManagement.Accounts.User

  # Function to create a user
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

    # Function to list all users
  def list_users do
    Repo.all(User)
  end

  alias TaskManagement.Accounts.Task

# function to create task for user
  def create_task(attrs) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end

  # function to get task for user
  def get_tasks_for_user(user_id) do
    Repo.all(from t in Task, where: t.user_id == ^user_id)
  end

end
