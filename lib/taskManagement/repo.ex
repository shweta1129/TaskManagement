defmodule TaskManagement.Repo do
  use Ecto.Repo,
    otp_app: :taskManagement,
    adapter: Ecto.Adapters.Postgres
end
