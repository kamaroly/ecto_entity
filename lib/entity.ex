defmodule Entity do
  @moduledoc """

  The missing Elixir Phoenix package to achieve Ecto > 80% common operations with < 20% effort.

  # Introduction

  Inspired by Laravel-Php Eloquent package, Entity includes injectable functions that makes it enjoyable to interact with your database.
  When using Entity, each database table has a corresponding Schema(Model) that is used to interact with that table.
  In addition to retrieving records from the database table, Entity allows you to insert, update, and delete records from the table as well.

  The goal of this package is to make it deadly simple to interact with Ecto without having to necessary write custom CRUD operations.

  ## Updates

  ### Updates a table record by ID

    iex> Person.update(1, %{first_name: "Kamaro"})
    iex> {:ok,
          %Person{
            __meta__: #Ecto.Schema.Metadata<:loaded, "people">,
            id: 1,
            first_name: "Kamaro",
            last_name: "Yundt",
            age: 7
          }}


  ### Updates entity by its schema

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
