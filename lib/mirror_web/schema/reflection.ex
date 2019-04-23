defmodule MirrorWeb.Schema.ReflectionTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Mirror.Repo

  alias MirrorWeb.Resolvers

  @desc "A user of the site"
  object :reflection do
    field(:id, :id)
    field(:learn, :string)
    field(:accomplish, :string)
    field(:user, :user, resolve: assoc(:user))
  end

  object :reflection_queries do
    @desc "Get all reflections"
    field :reflections, list_of(:reflection) do
      resolve(&Resolvers.ReflectionResolver.list/3)
    end

    @desc "Get a specific reflection"
    field :reflection, :reflection do
      arg(:id, non_null(:id))
      resolve(&Resolvers.ReflectionResolver.show/3)
    end

    @desc "Get a users reflections"
    field :reflections, list_of(:reflection) do
      resolve(&Resolvers.ReflectionResolver.user_reflections/3)
    end
  end

  object :reflection_mutations do
    @desc "Create reflection"
    field :create_reflection, :reflection do
      arg(:learn, non_null(:string)
      arg(:accomplish, non_null(:string))

      resolve(&Resolvers.ReflectionResolver.create/3)
    end
  end
end
