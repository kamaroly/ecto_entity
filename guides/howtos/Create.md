# Create

## `insert/1`

`create/1` and `insert/1` can be used to stores create table entry. 
Schema module must have changeset method implementedUse the create method, which accepts an schema of attributes, creates, and inserts it into the database.

The newly created schema will be returned by the create function.

```elixir
iex(1)> Person.create(%{first_name: "Hand", last_name: "Turner", age: 3})
{:ok,
%Person{
  __meta__: #Ecto.Schema.Metadata<:loaded, "people">,
  id: 125,
  first_name: "Hand",
  last_name: "Turner",
  age: 3
}}
```

## `create_many/1`

You may create many entries at once by passing a list of entries to  `create_many/1`.

```elixir
iex(1)> Person.create_many([
  %{first_name: "Parisian", last_name: "Beier", age: 7},
  %{first_name: "Lang", last_name: "Emard", age: 3}
])
{:ok, %{insert_all: {2, nil}}}
```
