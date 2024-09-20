import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :taskManagement, TaskManagement.Repo,
  adapter: Ecto.Adapters.SQLite3,
  database: Path.expand("priv/repo/taskmanagement_test.sqlite3"),
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :taskManagement, TaskManagementWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "cPiRoJJkE+otqgOL8zrYTJa3fuNk+4YMDDN9umlTkbsMFnoqJxm+mGlRK8EA2dmE",
  server: false

# In test we don't send emails
config :taskManagement, TaskManagement.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Enable helpful, but potentially expensive runtime checks
config :phoenix_live_view,
  enable_expensive_runtime_checks: true
