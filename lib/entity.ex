defmodule Entity do
  @moduledoc """
  Documentation for `Entity`.
  """

  import Ecto.Query
  alias Entity.AppHelpers

  defmacro __using__(_) do
    quote do
      @doc """
      Retrieves all database entries from a schema module

      ## Examples

          iex> SchemaModule.all()
          [%SchemaModule{}]

          iex> SchemaModule.all(query)
          [%SchemaModule{}]

      """
      def get_repo(), do: AppHelpers.get_repo()

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
      def first(query), do: query |> first() |> get_repo().one()
      def first!(query), do: query |> first() |> get_repo().one!()

      @doc """
      Retrieves the last database entry from a schema module

      ## Examples

          iex> SchemaModule.last()
          %SchemaModule{}

          iex> SchemaModule.last(query)
          %SchemaModule{}

      """
      def last(), do: __MODULE__ |> last() |> get_repo().one()
      def last(%Ecto.Query{} = query), do: query |> last() |> get_repo().one()
      def last(column) when is_atom(column), do: __MODULE__ |> last(column) |> get_repo().one()
      def last(%Ecto.Query{} = query, column) when is_atom(column), do: query |> last(column) |> get_repo().one()
      def last!(), do: __MODULE__ |> last() |> get_repo().one!()
      def last!(%Ecto.Query{} = query), do: query |> last() |> get_repo().one!()
      def last!(column) when is_atom(column), do: __MODULE__ |> last(column) |> get_repo().one!()
      def last!(%Ecto.Query{} = query, column) when is_atom(column), do: query |> last(column) |> get_repo().one!()

      @doc """
      Finds the a database entry from a schema module

      ## Examples

          iex> SchemaModule.find(id)
          %SchemaModule{}

          iex> SchemaModule.find!(id)
          %SchemaModule{}

      """
      def find(id), do: get_repo().get(__MODULE__, id)
      def find!(id), do: get_repo().get!(__MODULE__,id)

      @doc """
      Get a record by name

      ## Examples

          iex> SchemaModule.by_name(name)
              %SchemaModule{}
      """
      @spec by_name(resource_name :: String.t()) :: Resource.t()
      def by_name(resource_name) do
        get_repo().get_by!(__MODULE__, name: resource_name)
      end

      @doc """
      Stores a new data entry. Schema module must have changeset method implemented

      ## Examples

          iex> SchemaModule.create(attrs)
          {:ok, %SchemaModule{}}

      """
      def create(%{} = attrs) do
        __MODULE__.__struct__
          |> __MODULE__.changeset(attrs)
          |> get_repo().insert()
      end

      def insert(%{} = attrs), do: create(attrs)

      @doc """
      Updates the a database entry from a schema module

      ## Examples

          iex> SchemaModule.update(id, attrs)
          {:ok, %SchemaModule{}}

          iex> SchemaModule.update(%SchemaModule{}, attrs)
          {:ok, %SchemaModule{}}

      """
      def update(id, %{} = attrs) when not is_map(id) do
        find(id)
        |> __MODULE__.changeset(attrs)
        |> update_schema()
      end
      def update(__MODULE__ = schema, %{} = attrs) do
        schema
        |> __MODULE__.changeset(attrs)
        |> update_schema()
      end

      defp update_schema(query) do
         query
         |> get_repo().update()
      end

      def first_or_create(_attrs), do: raise "Implement this function"
      def update_or_create(_attrs), do: raise "Implement this function"

      def count(), do: all() |> Enum.count()
      def count(query), do: all(query) |> Enum.count()

      def size(), do: count()
      def size(query), do: count(query)

      @doc """
      Deletes the a database entry from a schema module

      ## Examples

          iex> SchemaModule.destroy(id)
          {:ok, %SchemaModule{}}

          iex> SchemaModule.destroy(%SchemaModule{})
          {:ok, %SchemaModule{}}

      """
      def destroy(id) do
        find!(id)
        |> get_repo().delete()
      end

      def oder_by(), do: __MODULE__ |> order_by(:id)
      def oder_by(column), do: __MODULE__ |> order_by(^column)


      # ASSOCIATIONS SECTION
      @spec with(query :: Queryable.t(), assoc :: List.t) :: List.t()
      def with(query, assocs) when is_list(assocs) do
        query |> get_repo().preload(assocs)
      end

      def with(query, assoc) when is_atom(assoc) do
        query |> get_repo().preload(assoc)
      end

      def with(assocs) when is_atom(assocs) or is_list(assocs) do
        all() |> get_repo().preload(assocs)
      end

      def where(params), do: __MODULE__ |> where(^params)
      def where(query, params), do: query |> where(^params)

      @doc """
      Get the table name for this schema

      ## Example
          iex> Person.table_name
          iex> "people"
      """
      def table_name, do: __MODULE__.__schema__(:source)

      @doc """
      Truncates a table and reset its index

      ## Example
        iex> Person.truncate
        iex> {:ok,
            %MyXQL.Result{
              columns: nil,
              connection_id: 707,
              last_insert_id: 0,
              num_rows: 0,
              rows: nil,
              num_warnings: 0
            }}
      """
      def truncate do
        get_repo().query("TRUNCATE #{table_name()}", [])
      end
    end
  end
end
