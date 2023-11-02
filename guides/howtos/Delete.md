# Delete

## `delete/1`

You may use `delete/1` or `destroy/1` to delete an existing table entry identifies by its ID.

```elixir
iex(1)> Person.delete(7)
{:ok,
%Person{
  __meta__: #Ecto.Schema.Metadata<:deleted, "people">,
  id: 7,
  first_name: "Glover",
  last_name: "Schimmel",
  age: 2
}}
```

`delete/1` works the same as `destroy/1`. It's just a preference in pronunciation. 

```elixir
iex(1)> Person.destroy(2)
{:ok,
%Person{
  __meta__: #Ecto.Schema.Metadata<:deleted, "people">,
  id: 2,
  first_name: "Ruecker",
  last_name: "Lemke",
  age: 0
}}
```
You may want to delete many records at once. You can do so by passing a list of the ids like the following. When you pass a list of ids to delete or destroy, Ecto.entity return {count_of_deleted_entities, nil}

```elixir
iex(2)> Person.delete([3, 6])
{2, nil}
```

## `delete_except/1`

You may wish to delete entries with exception using `delete_except/` or `destroy_except/`

```elixir
iex(1)> Person.delete_except([47, 48])
{48, nil}
iex(2)> Person.all()
[
  %Person{
    __meta__: #Ecto.Schema.Metadata<:loaded, "people">,
    id: 47,
    first_name: "Toy",
    last_name: "Weimann",
    age: 3
  },
  %Person{
    __meta__: #Ecto.Schema.Metadata<:loaded, "people">,
    id: 48,
    first_name: "Wilderman",
    last_name: "Treutel",
    age: 9
  }
]
```

## `truncate/0`

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
```