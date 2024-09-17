defmodule TaskManagement.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :name, :string
    field :email, :string
    field :age, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  # Changeset for user creation
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :age])
    |> validate_required([:name, :email])
    |> validate_format(:email, ~r/@/) 
    |> unique_constraint(:email)
  end
end
