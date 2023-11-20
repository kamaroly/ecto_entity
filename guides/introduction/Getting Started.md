
# Getting Started
This guide is an introduction to Ecto Entity, the missing Phoenix Ecto package to achieve +80% of common operations
less than 20% of effort it would normally take.
Ecto Entity provides a standardized API and a set of abstractions for interacting with database tables, so that your phoenix Elixir developers
can focus on what's specific to your project.

In this guide, we're going to learn some basics about Ecto Entity, such as creating,
reading, updating and destroying records from a database. If you want
to see the code from this guide, you can view it [at kamaroly/ecto_entity on GitHub](https://github.com/kamaroly/ecto_entity).

**This guide will require you to have setup Entity beforehand.**
## Installation
To add Entity to your application, The first step is to add Entity to your `mix.exs` file,
which we'll do by changing the `deps` definition in that file to this:

```elixir

  defp deps do
    [
      {:ecto_entity, "~> 1.0.0"}
    ]
  end

```

Then, to install it, you will run this command:

```
mix deps.get
```

## Configure Your Ecto Repo

Ecto Entity needs to know what repository to use while running database query. To do that, add `config :ecto_entity, app_name: :your_app_name` to your `config/config.exs` file. 
`:your_app_name` will be often the app configured in `mix.exs` under `project` > `app`.

```elixir
import Config
 
# Configure your APP name so that Ecto Entity can know
# What Ecto Repo to use for the entity
config :ecto_entity, app_name: :your_ecto_elixir_app_name

# Configure you pub server like the following. Replace `:app_name` with your app name
config :app_name, pubsub_server: Ecto.Entity.PubSub
```

## Adding Entity To Your Schema
To start off with, we'll need to include `Entity` in our existing Phoenix Schema using `use Ecto.Entity` in your Schema module, like the following:

```elixir

  defmodule MyApp.Person do
    import Ecto.Changeset
    use Ecto.Schema
    use Ecto.Entity # Include Entity in your normal schema

    schema "people" do
      field :first_name, :string
      field :last_name, :string
      field :age, :integer
    end

    def changeset(entity, attrs) do
      entity
      |> cast(attrs, [:first_name, :last_name])
      |> validate_required([:first_name, :last_name])
    end
  end
```

> NOTE: You must define a `changeset/2` function to create and update your schema
