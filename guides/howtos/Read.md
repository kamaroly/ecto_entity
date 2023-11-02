# Read

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
Person.find([1, 2, 3])
```

## `all/0` 

Returns all database entries from a schema module

```elixir

iex(1)> Person.all()
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

or take a specific number of records

```elixir
iex(1)> Person.take(2)
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