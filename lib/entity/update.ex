defmodule Ecto.Entity.Update do
  defmacro __using__(_) do
    quote do
      import Ecto.Entity.Helpers
      use Ecto.Entity.Read, only: [find: 1, in_ids: 1]

      @doc """
      Updates a table record by ID
      
      ## Example
            iex> Person.update(1, %{first_name: "Kamaro"})
            iex> {:ok,
                  %Person{
                    __meta__: #Ecto.Schema.Metadata<:loaded, "people">,
                    id: 1,
                    first_name: "Kamaro",
                    last_name: "Yundt",
                    age: 7
                  }}
      """
      def update(id, %{} = attrs) when is_integer(id) and is_map(attrs) do
        find(id) |> update_schema(attrs)
      end

      @doc """
        Update an entity by the schema.
        ## Examples
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
      def update(entity, attrs) when is_map(entity) and is_map(attrs) do
        update_schema(entity, attrs)
      end

      def update_many(query, attrs), do: raise("update_many/2 is yet to be implemented")

      @doc false
      defp update_schema(entity, attrs) do
        __MODULE__.changeset(entity, attrs)
        |> get_repo().update!()
      end
    end
  end
end
