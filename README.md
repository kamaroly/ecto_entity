# Ecto Entity


# Introduction

The missing Elixir Phoenix package to achieve Ecto > 80% common operations with < 20% effort.

Inspired by Laravel/ Php Eloquent package, Ecto Entity includes injectable functions that makes it enjoyable to interact with your database.
When using Ecto Entity, each database table has a corresponding Schema(Model) that is used to interact with that table.
In addition to retrieving records from the database table, Ecto Entity allows you to insert, update, and delete records from the table as well.

The goal of this package is to make it deadly simple to interact with Ecto without having to necessary write custom CRUD operations.

# Getting Started
This guide is an introduction to Ecto Entity, the missing Phoenix Ecto package to achieve +80% of common operations
less than 20% of effort it would normally take.
Ecto Entity provides a standardized API and a set of abstractions for interacting with database tables, so that your phoenix Elixir developers
can focus on what's specific to your project.

In this guide, we're going to learn some basics about Ecto Entity, such as creating,
reading, updating and destroying records from a database. If you want
to see the code from this guide, you can view it [at kamaroly/ecto_entity on GitHub](https://github.com/kamaroly/ecto_entity).

**This guide will require you to have setup Entity beforehand.**
# Installation
To add Entity to your application, The first step is to add Entity to your `mix.exs` file,
which we'll do by changing the `deps` definition in that file to this:

```elixir

  defp deps do
    [
      {:ecto_entity, "~> 0.1.0"}
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

# CREATE

`create/1` and `insert/1` can be used to stores create table entry. 
Schema module must have changeset method implementedUse the create method, which accepts an schema of attributes, creates, and inserts it into the database.

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

# READ 

## `find/1`

Returns entry with id matching what passed

```elixir
  iex(1)> Person.find(5)
  %Person{
    __meta__: #Ecto.Schema.Metadata<:loaded, "people">,
    id: 5,
    first_name: "Kristopher",
    last_name: "Keeling",
    age: 9
  }
```

or find multiple entities with the provided identifiers like the following

```elixir
iex(17)> Person.find([1, 2, 3])
[
  %Person{
    __meta__: #Ecto.Schema.Metadata<:loaded, "people">,
    id: 1,
    first_name: "Graham",
    last_name: "Jones",
    age: 0
  },
  %Person{
    __meta__: #Ecto.Schema.Metadata<:loaded, "people">,
    id: 2,
    first_name: "Murl",
    last_name: "Hackett",
    age: 9
  },
  %Person{
    __meta__: #Ecto.Schema.Metadata<:loaded, "people">,
    id: 3,
    first_name: "Fahey",
    last_name: "Windler",
    age: 4
  }
]
```

## `all/0` 

Returns all database entries from a schema module

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

## `take/1` 

Returns x number of records

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

## `first/0` 
Returns the first table entry

```elixir

iex(1)> Person.first()
%Person{
  __meta__: #Ecto.Schema.Metadata<:loaded, "people">,
  id: 1,
  first_name: "Johnson",
  last_name: "Bradtke",
  age: 4
}
iex(2)>
```

## `last/0` 

Returns the last table entry

```elixir

iex(1)> Person.last()

%Person{
  __meta__: #Ecto.Schema.Metadata<:loaded, "people">,
  id: 36,
  first_name: "Cedrick",
  last_name: "Donnelly",
  age: 2
}
```

## `except/1` 

Returns results except the records with the id provided

```elixir
iex(1)> Person.all()
[
  %Person{
    __meta__: #Ecto.Schema.Metadata<:loaded, "people">,
    id: 1,
    first_name: "Hudson",
    last_name: "Berge",
    age: 9
  },
  %Person{
    __meta__: #Ecto.Schema.Metadata<:loaded, "people">,
    id: 2,
    first_name: "Hamill",
    last_name: "Wunsch",
    age: 2
  },
  %Person{
    __meta__: #Ecto.Schema.Metadata<:loaded, "people">,
    id: 3,
    first_name: "Alden",
    last_name: "Kovacek",
    age: 0
  }
]
iex(2)> Person.except([1, 2])
[
  %Person{
    __meta__: #Ecto.Schema.Metadata<:loaded, "people">,
    id: 3,
    first_name: "Alden",
    last_name: "Kovacek",
    age: 0
  }
]
```

Or provide only 1 record to exclude

```elixir
iex(1)> Person.except(1)
[
  %Person{
    __meta__: #Ecto.Schema.Metadata<:loaded, "people">,
    id: 2,
    first_name: "Hamill",
    last_name: "Wunsch",
    age: 2
  },
  %Person{
    __meta__: #Ecto.Schema.Metadata<:loaded, "people">,
    id: 3,
    first_name: "Alden",
    last_name: "Kovacek",
    age: 0
  }
]
```

# UPDATE 

Updates an existing entry
## `update/2`

Updates an existing record identified by an ID

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

## `updates/2` 

Updates an existing record identified by its Schema(Model)

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

# DELETE

#### `delete/1`

You may use `delete/1` or `destroy/1` to delete an existing table entry identifies by its ID.

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

#### `destroy/1`

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
#### `truncate`

You may truncate a database table by `truncate/0`. `truncate` delete all entries and reset the table index.

```elixir
iex(1)> Person.truncate()
{:ok,
 %MyXQL.Result{
   columns: nil,
   connection_id: 788,
   last_insert_id: 0,
   num_rows: 0,
   rows: nil,
   num_warnings: 0
 }}
iex(2)>

```
