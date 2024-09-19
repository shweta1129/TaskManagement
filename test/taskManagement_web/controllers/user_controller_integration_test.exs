defmodule TaskManagementWeb.UserIntegrationTest do
  use TaskManagementWeb.ConnCase, async: true

  @create_attrs %{name: "Mark Henry", email: "henry.mark@gmail.com", age: 22}
  @invalid_attrs %{name: nil, email: nil, age: nil}

  describe "User API Integration" do
    test "creates a new user and then fetches the user list", %{conn: conn} do
      # Step 1: Create a new user
      conn = post(conn, "/api/users", user: @create_attrs)
      assert %{"message" => "User created successfully", "user" => user} = json_response(conn, 201)

      # Step 2: Fetch all users and verify the created user is listed
      conn = get(conn, "/api/users")
      assert %{"users" => users} = json_response(conn, 200)
      assert length(users) == 1
      assert hd(users)["email"] == "henry.mark@gmail.com"
    end
  end
end
