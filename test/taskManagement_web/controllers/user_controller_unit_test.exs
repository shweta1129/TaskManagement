defmodule TaskManagementWeb.UserControllerTest do
  use TaskManagementWeb.ConnCase, async: true
  alias TaskManagement.Accounts.User
  alias TaskManagement.Accounts

  @create_attrs %{name: "Mark Henry", email: "henry.mark@gmail.com", age: 22}
  @invalid_attrs %{name: nil, email: nil, age: nil}

  describe "POST /users" do
    test "creates a new user and returns 201 status", %{conn: conn} do
      conn = post(conn, "/api/users", user: @create_attrs)

      assert %{"message" => "User created successfully"} = json_response(conn, 201)
      assert TaskManagement.Repo.get_by(User, email: "henry.mark@gmail.com")
    end

    test "returns an error when data is invalid", %{conn: conn} do
      conn = post(conn, "/api/users", user: @invalid_attrs)

      assert %{"errors" => _} = json_response(conn, 422)
    end
  end

    describe "GET /users" do
    test "lists all users", %{conn: conn} do
      user = Accounts.create_user(@create_attrs)
      conn = get(conn, "/api/users")

      assert %{"users" => users} = json_response(conn, 200)
      assert length(users) == 1
      assert hd(users)["email"] == "henry.mark@gmail.com"
    end
  end

end
