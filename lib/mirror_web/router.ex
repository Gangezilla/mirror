defmodule MirrorWeb.Router do
  use MirrorWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/" do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", MirrorWeb.PageController, :index)
  end

  scope "/" do
    pipe_through(:api)

    forward("/graphiql", Absinthe.Plug.GraphiQL, schema: MirrorWeb.Schema)
  end

  # Other scopes may use custom stacks.
  # scope "/api", MirrorWeb do
  #   pipe_through :api
  # end
end
