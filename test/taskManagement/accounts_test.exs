defmodule TaskManagement.AccountsTest do
  use TaskManagement.DataCase

  alias TaskManagement.Accounts

  describe "users" do
    alias TaskManagement.Accounts.User

    import TaskManagement.AccountsFixtures

    @invalid_attrs %{name: nil, email: nil, age: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Accounts.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Accounts.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{name: "some name", email: "some email", age: 42}

      assert {:ok, %User{} = user} = Accounts.create_user(valid_attrs)
      assert user.name == "some name"
      assert user.email == "some email"
      assert user.age == 42
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{name: "some updated name", email: "some updated email", age: 43}

      assert {:ok, %User{} = user} = Accounts.update_user(user, update_attrs)
      assert user.name == "some updated name"
      assert user.email == "some updated email"
      assert user.age == 43
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_user(user, @invalid_attrs)
      assert user == Accounts.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Accounts.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Accounts.change_user(user)
    end
  end

  describe "tasks" do
    alias TaskManagement.Accounts.Task

    import TaskManagement.AccountsFixtures

    @invalid_attrs %{status: nil, description: nil, title: nil, due_date: nil}

    test "list_tasks/0 returns all tasks" do
      task = task_fixture()
      assert Accounts.list_tasks() == [task]
    end

    test "get_task!/1 returns the task with given id" do
      task = task_fixture()
      assert Accounts.get_task!(task.id) == task
    end

    test "create_task/1 with valid data creates a task" do
      valid_attrs = %{status: "some status", description: "some description", title: "some title", due_date: ~D[2024-09-17]}

      assert {:ok, %Task{} = task} = Accounts.create_task(valid_attrs)
      assert task.status == "some status"
      assert task.description == "some description"
      assert task.title == "some title"
      assert task.due_date == ~D[2024-09-17]
    end

    test "create_task/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_task(@invalid_attrs)
    end

    test "update_task/2 with valid data updates the task" do
      task = task_fixture()
      update_attrs = %{status: "some updated status", description: "some updated description", title: "some updated title", due_date: ~D[2024-09-18]}

      assert {:ok, %Task{} = task} = Accounts.update_task(task, update_attrs)
      assert task.status == "some updated status"
      assert task.description == "some updated description"
      assert task.title == "some updated title"
      assert task.due_date == ~D[2024-09-18]
    end

    test "update_task/2 with invalid data returns error changeset" do
      task = task_fixture()
      assert {:error, %Ecto.Changeset{}} = Accounts.update_task(task, @invalid_attrs)
      assert task == Accounts.get_task!(task.id)
    end

    test "delete_task/1 deletes the task" do
      task = task_fixture()
      assert {:ok, %Task{}} = Accounts.delete_task(task)
      assert_raise Ecto.NoResultsError, fn -> Accounts.get_task!(task.id) end
    end

    test "change_task/1 returns a task changeset" do
      task = task_fixture()
      assert %Ecto.Changeset{} = Accounts.change_task(task)
    end
  end
end
