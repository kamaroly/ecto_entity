defmodule Entity.Delete do
  import Entity.Helpers, only: [get_repo: 0]
  use Entity.Read, only: [find!: 1]

  defmacro __using__(_) do
    quote do
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

      @doc """
        Deletes the a database entry from a schema module

        ## Examples

            iex> Person.delete(31)
            iex> {:ok,
              %Person{
                __meta__: #Ecto.Schema.Metadata<:deleted, "people">,
                id: 31,
                first_name: "Roman",
                last_name: "Haag",
                age: nil
              }}

        """
        def destroy(id) when not is_map(id), do: find!(id) |> get_repo().delete()
        def destroy(entity) when is_map(entity), do: destroy(entity.id)

        def delete(entity), do: destroy(entity)

      end
    end
end
