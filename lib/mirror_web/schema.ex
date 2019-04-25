defmodule MirrorWeb.Schema do
  use Absinthe.Schema
  import_types(Absinthe.Type.Custom)
  import_types(MirrorWeb.Schema.UserTypes)
  import_types(MirrorWeb.Schema.ReflectionTypes)

  query do
    import_fields(:user_queries)
    import_fields(:reflection_queries)
  end

  mutation do
    import_fields(:user_mutations)
    import_fields(:reflection_mutations)
  end
end
