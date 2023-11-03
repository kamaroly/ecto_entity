import Config

# Configure your APP name so that Ecto Entity can know
# What Ecto Repo to use for the entity
config :ecto_entity, app_name: :ecto_entity
config :ecto_entity, timezone: "Etc/UTC"

config :ecto_entity, Ecto.Entity.Repo,
  database: System.get_env("DATABASE_NAME", "entity"),
  username: System.get_env("DATABASE_USERNAME", "root"),
  password: System.get_env("DATABASE_PASSWORD", ""),
  hostname: System.get_env("DATABASE_HOST_NAME", "127.0.0.1"),
  port: String.to_integer(System.get_env("DATABASE_PORT", "3306"))

config :ecto_entity, ecto_repos: [Ecto.Entity.Repo]
