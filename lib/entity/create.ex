defmodule Entity.Create do
  import Entity.Helpers
  defmacro __using__(_) do
    quote do
      @doc """
      Stores a new data entry. Schema module must have changeset method implementedUse the create method,
      which accepts an schema of attributes, creates, and inserts it into the database.
      The newly created schema will be returned by the create function:

      ## Example

      iex> Person.create(%{first_name: "Hand", last_name: "Turner", age: 3})
      {:ok,
      %Person{
        __meta__: #Ecto.Schema.Metadata<:loaded, "people">,
        id: 125,
        first_name: "Hand",
        last_name: "Turner",
        age: 3
      }}
      """
      def create(%{} = attrs) do
        __MODULE__.__struct__
          |> __MODULE__.changeset(attrs)
          |> get_repo().insert()
      end
      def insert(%{} = attrs), do: create(attrs)

      @doc false
      def create_many([] = create_many), do: raise "To be implemented in future version"
    end
  end
end
