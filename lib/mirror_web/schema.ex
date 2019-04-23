defmodule MirrorWeb.Schema do
  use Absinthe.Schema
  import_types(Absinthe.Type.Custom)
  import_types(MirrorWeb.Schema.UserTypes)

  query do
    import_fields(:user_queries)
  end

  mutation do
    import_fields(:user_mutations)
  end
end
