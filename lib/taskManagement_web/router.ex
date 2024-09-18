defmodule TaskManagementWeb.Router do
  use TaskManagementWeb, :router  # Correct usage of the router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api/users", TaskManagementWeb do
    pipe_through :api

    # User routes
    post "/", UserController, :create
    get "/", UserController, :index

  end
end
