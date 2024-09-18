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

    # Task routes
    post "/:user_id/tasks", TaskController, :create
    get "/:user_id/tasks", TaskController, :index
    get "/:user_id/tasks/:task_id", TaskController, :show

  end
end
