import Config

config :entity, Entity.Repo,
  database: System.get_env("DATABASE_NAME", "entity"),
  username: System.get_env("DATABASE_USERNAME", "root"),
  password: System.get_env("DATABASE_PASSWORD", ""),
  hostname: System.get_env("DATABASE_HOST_NAME", "127.0.0.1"),
  port: String.to_integer(System.get_env("DATABASE_PORT", "3306"))

config :entity,
      ecto_repos: [Entity.Repo]
