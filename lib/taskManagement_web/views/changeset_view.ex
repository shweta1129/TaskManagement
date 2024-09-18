defmodule TaskManagementWeb.ChangesetView do
  use TaskManagementWeb, :view

  def render("error.json", %{changeset: changeset}) do
    %{errors: translate_errors(changeset)}
  end

  # function to format errot
  defp translate_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end
end
