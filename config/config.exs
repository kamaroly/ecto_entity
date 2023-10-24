import Config

config :entity, Entity.Repo,
  database: "entity",
  username: "root",
  password: "",
  hostname: "localhost"

config :entity,
      ecto_repos: [Entity.Repo]
