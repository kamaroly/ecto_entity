defmodule Ecto.Entity.Create do
  defmacro __using__(_) do
    quote do
      import Ecto.Entity.Helpers
      use Ecto.Entity.Changes

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
      def create(%{} = attrs), do: module_change(attrs) |> get_repo().insert()
      def insert(%{} = attrs), do: create(attrs)

      @doc """
      Create many entries at once

      ## Example
          iex> Person.create_many([
            %{first_name: "Parisian", last_name: "Beier", age: 7},
            %{first_name: "Lang", last_name: "Emard", age: 3}
          ])
      """
      def create_many(attrs) when is_list(attrs) do
        attrs =
           attrs
           |> put_inserted_at()
           |> put_updated_at()

        Ecto.Multi.new()
        |> Ecto.Multi.insert_all(:insert_all, __MODULE__, attrs)
        |> get_repo().transaction()
      end

      def insert_many(attrs) when is_list(attrs), do: create_many(attrs)

    end
  end
end
