defmodule MirrorWeb.Resolvers.ReflectionResolver do
  alias Mirror.Reflections

  def get_reflection_by_id(_parent, args, _resolutions) do
    case Reflections.find(args[:id]) do
      nil -> {:error, "Not found"}
      reflection -> {:ok, reflection}
    end
  end

  def get_all_users_reflections(_parent, args, _resolutions) do
    case Reflections.get_all_users_reflections(args[:user_id]) do
      nil -> {:error, "Not found"}
      reflections -> {:ok, reflections}
    end
  end

  def create_new_reflection(_parent, args, %{
        context: %{current_user: current_user}
      }) do
    args
    |> Map.put(:user_id, current_user.id)
    |> Reflections.create()
    |> case do
      {:ok, post} ->
        {:ok, post}

      {:error, changeset} ->
        {:error, extract_error_msg(changeset)}
    end
  end

  def extract_error_msg(changeset) do
    changeset.errors
    |> Enum.map(fn {field, {error, _details}} ->
      [
        field: field,
        message: String.capitalize(error)
      ]
    end)
  end
end
