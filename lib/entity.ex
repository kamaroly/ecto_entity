defmodule Entity do
  @moduledoc """

  # Entity

  The missing Elixir Phoenix package to achieve Ecto > 80% common operations with < 20% effort.

  # Introduction

  Inspired by Laravel-Php Eloquent package, Entity includes injectable functions that makes it enjoyable to interact with your database.
  When using Entity, each database table has a corresponding Schema(Model) that is used to interact with that table.
  In addition to retrieving records from the database table, Entity allows you to insert, update, and delete records from the table as well.

  The goal of this package is to make it deadly simple to interact with Ecto without having to necessary write custom CRUD operations.

  # Getting Started
  This guide is an introduction to Entity, the missing Phoenix Ecto package to achieve +80% of common operations
  less than 20% of effort it would normally take.
  Entity provides a standardized API and a set of abstractions for interacting with database tables, so that your phoenix Elixir developers
  can focus on what's specific to your project.

  In this guide, we're going to learn some basics about Entity, such as creating,
  reading, updating and destroying records from a database. If you want
  to see the code from this guide, you can view it [at kamaroly/ecto_entity on GitHub](https://github.com/kamaroly/ecto_entity).

  **This guide will require you to have setup Entity beforehand.**
  ## Install Entity in your Phoenix / Elixir App
  To add Entity to your application, The first step is to add Entity to your `mix.exs` file,
  which we'll do by changing the `deps` definition in that file to this:

  ```elixir

    defp deps do
      [
        {:entity, "~> 0.1.0"}
      ]
    end

  ```

  Then, to install it, you will run this command:

  ```
  mix deps.get
  ```

  To start off with, we'll need to include `Entity` in our existing Phoenix Schema like the following:

  ```elixir

    defmodule MyApp.Person do
      import Ecto.Changeset
      use Ecto.Schema
      use Entity

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

  ## The `create/1` and `insert/1` function
  You can use `create` or `insert` stores a new data entry. Schema module must have changeset method implementedUse the create method,
  which accepts an schema of attributes, creates, and inserts it into the database.
  The newly created schema will be returned by the create function.

  ```elixir
  iex> Person.create(%{first_name: "Hand", last_name: "Turner", age: 3})
  {:ok,
  %Person{
    __meta__: #Ecto.Schema.Metadata<:loaded, "people">,
    id: 125,
    first_name: "Hand",
    last_name: "Turner",
    age: 3
  }}
  ```

  ## Reading methods

  ### The `find/1` returns entry with id matching what passed

  ```elixir

    iex> Person.find(5)
    %Person{
      __meta__: #Ecto.Schema.Metadata<:loaded, "people">,
      id: 5,
      first_name: "Kristopher",
      last_name: "Keeling",
      age: 9
    }
  ```

  ### The `all/0` function to return all table entries

  Retrieves all database entries from a schema module

  ```elixir

  iex> Person.all()
      [
        %Person{
          __meta__: #Ecto.Schema.Metadata<:loaded, "people">,
          id: 1,
          first_name: "German",
          last_name: "OConnell",
          age: 2
        },
        %Person{
          __meta__: #Ecto.Schema.Metadata<:loaded, "people">,
          id: 2,
          first_name: "Fritsch",
          last_name: "Kassulke",
          age: 8
        },
        %Person{
          __meta__: #Ecto.Schema.Metadata<:loaded, "people">,
          id: 3,
          first_name: "Russel",
          last_name: "Collins",
          age: 3
        }
      ]

  ```
  ### The `take/1` function to return x number of records

  ```elixir

  iex> Person.take(2)
    [
    %Person{
      __meta__: #Ecto.Schema.Metadata<:loaded, "people">,
      id: 1,
      first_name: "German",
      last_name: "OConnell",
      age: 2
    },
    %Person{
      __meta__: #Ecto.Schema.Metadata<:loaded, "people">,
      id: 2,
      first_name: "Fritsch",
      last_name: "Kassulke",
      age: 8
    }
  ]

  ```

  ### The `first/0` function to return the first table entry

  ### The `last/0` function to return the last table entry


  ## The `update/2` function

  ### Updates a table record by ID

  ```elixir
    iex> Person.update(1, %{first_name: "Kamaro"})
    iex> {:ok,
          %Person{
            __meta__: #Ecto.Schema.Metadata<:loaded, "people">,
            id: 1,
            first_name: "Kamaro",
            last_name: "Yundt",
            age: 7
          }}

  ```

  ### Updates entity by its schema

  ```elixir

  iex(1)> person = Person.find(1)
  %Person{
    __meta__: #Ecto.Schema.Metadata<:loaded, "people">,
    id: 1,
    first_name: "Weber",
    last_name: "Ok 2",
    age: 7
  }
  iex(2)> Person.update(person, %{first_name: "Kamaro"})
    {:ok,
    %Person{
      __meta__: #Ecto.Schema.Metadata<:loaded, "people">,
      id: 1,
      first_name: "Kamaro",
      last_name: "Ok 2",
      age: 7
    }}
  ```

  ## The `delete/1` and `destroy/` functions

  #### `delete`

  ```elixir
  iex(2)> Person.delete(7)
      {:ok,
      %Person{
        __meta__: #Ecto.Schema.Metadata<:deleted, "people">,
        id: 7,
        first_name: "Glover",
        last_name: "Schimmel",
        age: 2
      }}
  ```

  #### `destroy`

  ```elixir

  iex(3)> Person.destroy(2)
  {:ok,
  %Person{
    __meta__: #Ecto.Schema.Metadata<:deleted, "people">,
    id: 2,
    first_name: "Ruecker",
    last_name: "Lemke",
    age: 0
  }}

  ```

  """
  defmacro __using__(_) do
    quote do
      use Entity.{
        Create,
        Read,
        Update,
        Delete,
        Association
      }
    end
  end
end
