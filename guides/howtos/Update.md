# Update 

Updates an existing entry
## `update/2`

Updates an existing record identified by an ID

```elixir
iex(1)> Person.update(1, %{first_name: "Kamaro"})
{:ok,
%Person{
    __meta__: #Ecto.Schema.Metadata<:loaded, "people">,
    id: 1,
    first_name: "Kamaro",
    last_name: "Yundt",
    age: 7
  }}
```

Updates an existing record identified by its Schema(Model)

```elixir
# Find a person by id 1
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

## `update_many/1`

You may update many entries at once using `update_many/2` like the following

```elixir

iex(1)> query = Person.not_in_ids(1)
#Ecto.Query<from p0 in Person, where: p0.id not in ^[1]>
iex(2)>Person.update_many(query, [first_name: "Kamaro Paul"])
{:ok, %{update_all: {2, nil}}}
```