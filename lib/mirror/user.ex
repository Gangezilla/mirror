defmodule Mirror.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias Mirror.{Repo, Reflections}

  schema "user" do
    field(:first_name, :string)
    field(:last_name, :string)
    field(:email, :string)
    field(:username, :string)
    field(:code, :string)

    has_many(:reflections, Reflections)

    timestamps()
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

  def changeset(%__MODULE__{} = user, attrs) do
    user
    |> cast(attrs, [:first_name, :last_name, :email, :username, :code])
    |> validate_required([:first_name, :last_name, :email, :username, :code])
    |> unique_constraint(:email)
  end
end
