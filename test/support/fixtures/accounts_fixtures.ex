defmodule TaskManagement.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TaskManagement.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        age: 42,
        email: "some email",
        name: "some name"
      })
      |> TaskManagement.Accounts.create_user()

    user
  end

  @doc """
  Generate a task.
  """
  def task_fixture(attrs \\ %{}) do
    {:ok, task} =
      attrs
      |> Enum.into(%{
        description: "some description",
        due_date: ~D[2024-09-17],
        status: "some status",
        title: "some title"
      })
      |> TaskManagement.Accounts.create_task()

    task
  end
end
