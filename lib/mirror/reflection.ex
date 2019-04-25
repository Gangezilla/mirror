defmodule Mirror.Reflections do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias Mirror.{Repo, User}

  schema "reflections" do
    field(:learn, :string)
    field(:accomplish, :string)

    belongs_to(:user, User)
  end

  def all do
    Repo.all(from(r in __MODULE__, order_by: [desc: r.id]))
  end

  def get_all_users_reflections(user_id) do
    Repo.all(from(r in __MODULE__, where: r.user_id == ^user_id, order_by: [desc: r.id]))
  end

  def find(id) do
    Repo.get(__MODULE__, id)
  end

  def create(attrs) do
    attrs
    |> changeset()
    |> Repo.insert()
  end

  def changeset(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
  end

  def changeset(reflection, attrs) do
    reflection
    |> cast(attrs, [:learn, :accomplish, :user_id])
    |> validate_required([:learn, :accomplish, :user_id])
    |> foreign_key_constraint(:user_id)
  end
end
