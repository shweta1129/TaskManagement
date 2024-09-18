defmodule TaskManagement.Accounts.Task do
  use Ecto.Schema
  import Ecto.Changeset

    @derive {Jason.Encoder, only: [:id, :title, :description, :due_date, :status, :user_id, :inserted_at, :updated_at]}

  schema "tasks" do
    field :status, :string
    field :description, :string
    field :title, :string
    field :due_date, :date
    belongs_to :user, TaskManagement.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description, :due_date, :status, :user_id])
    |> validate_required([:title, :status, :user_id])
    |> validate_inclusion(:status, ["To Do", "In Progress", "Done"])
  end
end
