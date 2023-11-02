# Conditions

Conditions help you to retrieve data based on the specific conditions. You may do it using where condition.

```elixir 
Person.where(:first_name, "Kamaro")
#Ecto.Query<from p0 in Person, where: p0.first_name == ^"Kamaro">
```

You may return the first entry that matches the provided where condition like the following:
```elixir 
Person.where_first(:first_name, "Dominic")
%Person{
  __meta__: #Ecto.Schema.Metadata<:loaded, "people">,
  id: 42,
  first_name: "Dominic",
  last_name: "Cummings",
  age: 6
}
```

Or return all entries that matches a given condition like the following:

```elixir
Person.where_all(:age, 6)                                                                 
[                                                                                                      
  %Person{                                                                                             
    __meta__: #Ecto.Schema.Metadata<:loaded, "people">,                                                
    id: 9,                                                                                             
    first_name: "Kihn",                                                                                
    last_name: "Graham",                                                                               
    age: 6                                                                                             
  },                                                                                                   
  %Person{                                                                                             
    __meta__: #Ecto.Schema.Metadata<:loaded, "people">,                                                
    id: 15,                                                                                            
    first_name: "Cummerata",                                                                           
    last_name: "Altenwerth",                                                                           
    age: 6                                                                                             
  },                                                                                                   
  %Person{                                                                                             
    __meta__: #Ecto.Schema.Metadata<:loaded, "people">,                                                
    id: 37,                                                                                            
    first_name: "Pollich",                                                                             
    last_name: "Crist",                                                                                
    age: 6                                                                                             
  },                                                                                                   
  %Person{                                                                                             
    __meta__: #Ecto.Schema.Metadata<:loaded, "people">,                                                
    id: 39,                                                                                            
    first_name: "Daugherty",                                                                           
    last_name: "Mills",                                                                                
    age: 6                                                                                             
  },                                                                                                   
  %Person{                                                                                             
    __meta__: #Ecto.Schema.Metadata<:loaded, "people">,                                                
    id: 41,                                                                                            
    first_name: "Alfonso",                                                                             
    last_name: "Nitzsche",                                                                             
    age: 6                                                                                             
  },                                                                                                   
  %Person{                                                                                             
    __meta__: #Ecto.Schema.Metadata<:loaded, "people">,                                                
    id: 42,                                                                                            
    first_name: "Dominic",                                                                             
    last_name: "Cummings",                                                                             
    age: 6                                                                                             
  }                                                                                                    
]                                                                                                      
```