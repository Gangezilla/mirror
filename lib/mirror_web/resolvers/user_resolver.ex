defmodule MirrorWeb.Resolvers.UserResolver do
  alias Mirror.User

  def current_user(_parent, _args, %{context: %{current_user: current_user}}) do
    {:ok, current_user}
  end

  def current_user(_parent, _args, _resolutions) do
    {:error, "Unauthenticated"}
  end

  def signup(_parent, args, _resolution) do
    args
    |> User.create()
    |> case do
      # {:ok, user} -> TODO HANDLE WHAT HAPPENS WHEN WE SIGN UP
      {:error, changeset} -> {:error, extract_error_msg(changeset)}
    end
  end

  defp extract_error_msg(changeset) do
    changeset.errors
    |> Enum.map(fn {field, {error, _details}} ->
      [
        field: field,
        message: String.capitalize(error)
      ]
    end)
  end
end
