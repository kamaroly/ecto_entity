defmodule Entity.Read do
  import Ecto.Query
  import Entity.Helpers

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

            @doc """
            Finds the a database entry from a schema module

            ## Examples

                iex> SchemaModule.find(id)
                %SchemaModule{}

                iex> SchemaModule.find!(id)
                %SchemaModule{}

            """
            def find(id), do: get_repo().get(__MODULE__, id)
            def find!(id), do: get_repo().get!(__MODULE__, id)

            def count(), do: all() |> Enum.count()
            def count(query), do: all(query) |> Enum.count()

            def size(), do: count()
            def size(query), do: count(query)

            def oder_by(), do: __MODULE__ |> order_by(:id)
            def oder_by(column), do: __MODULE__ |> order_by(^column)
        end
    end
end
