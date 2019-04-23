defmodule MirrorWeb.Schema.UserTypes do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Mirror.Repo

  alias MirrorWeb.Resolvers

  @desc "A user of the site"
  object :user do
    field(:id, :id)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:email, :string)
    field(:username, :string)
    field(:code, :string)
    field(:reflections, list_of(:reflection), resolve: assoc(:reflections))
  end

  object :user_queries do
    @desc "Get current user"
    field :current_user, :user do
      resolve(&Resolvers.UserResolver.current_user/3)
    end
  end

  object :user_mutations do
    @desc "Sign up"
    field :sign_up, :user do
      arg(:first_name, non_null(:string))
      arg(:last_name, non_null(:string))
      arg(:email, non_null(:string))
      arg(:username, non_null(:string))

      resolve(&Resolvers.UserResolver.signup/3)
    end
  end
end
