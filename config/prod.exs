use Mix.Config

config :mirror, MirrorWeb.Endpoint,
  http: [port: System.get_env("PORT")],
  url: [scheme: "https", host: "mirror1.herokuapp.com", port: 443],
  force_ssl: [rewrite_on: [:x_forwarded_proto]],
  cache_static_manifest: "priv/static/cache_manifest.json",
  secret_key_base: Map.fetch!(System.get_env(), "SECRET_KEY_BASE")

config :logger, level: :info

# Configure your database
import_config "prod.secret.exs"
