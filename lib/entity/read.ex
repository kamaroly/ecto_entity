defmodule Ecto.Entity.Read do
  defmacro __using__(_) do
    quote do
      import Ecto.Query
      import Ecto.Entity.Helpers

      @doc """
      Retrieves all database entries from a schema module

      ## Examples

          iex> SchemaModule.all()
          [%SchemaModule{}]

          iex> SchemaModule.all(query)
          [%SchemaModule{}]

      """
      def all(), do: get_repo().all(__MODULE__)
      def all(query), do: query |> get_repo().all()
      def get(), do: all()
      def get(query), do: query |> get_repo().all()

      def take(number), do: __MODULE__ |> limit(^number) |> get_repo().all()
      def take(query, number), do: query |> limit(^number) |> get_repo().all()

      @doc """
      Retrieves the first database entry from a schema module

      ## Examples

          iex> SchemaModule.first()
          %SchemaModule{}

          iex> SchemaModule.first(query)
          %SchemaModule{}

      """
      def first(), do: __MODULE__ |> first() |> get_repo().one()
      def first!(), do: __MODULE__ |> first() |> get_repo().one!()
      def first!(query), do: first(query) |> get_repo().one!()

      @doc """
      Retrieves the last database entry from a schema module

      ## Examples

          iex> SchemaModule.last()
          %SchemaModule{}

          iex> SchemaModule.last(query)
          %SchemaModule{}

      """
      def last(), do: __MODULE__ |> last() |> get_repo().one()

      @doc """
      Finds the a database entry from a schema module

      ## Examples

          iex> SchemaModule.find(id)
          %SchemaModule{}

          iex> SchemaModule.find!(id)
          %SchemaModule{}

      """
      def find(ids) when is_list(ids), do: in_ids(ids) |> all()
      def find(id), do: get_repo().get(__MODULE__, id)
      def find!(id), do: get_repo().get!(__MODULE__, id)

      @doc """
      Returns entries except the ones with ids provided

      ## Examples
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
      """
      def except(ids) when is_list(ids), do: not_in_ids(ids) |> all()
      def except(id), do: except([id])

      def count(), do: all() |> Enum.count()
      def count(query), do: all(query) |> Enum.count()

      def size(), do: count()
      def size(query), do: count(query)

      def oder_by(), do: __MODULE__ |> order_by(:id)
      def oder_by(column), do: __MODULE__ |> order_by(^column)

      def in_ids(ids) when is_list(ids), do: from(p in __MODULE__, where: p.id in ^ids)
      def not_in_ids(ids) when is_list(ids), do: from(p in __MODULE__, where: p.id not in ^ids)

      def where_first(field, value) do
         __MODULE__.where(field, value)
         |> first() |> get_repo().one()
      end

      def where_all(field, value), do: __MODULE__.where(field, value) |> all()
    end
  end
end
