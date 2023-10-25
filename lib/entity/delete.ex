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

            iex> SchemaModule.destroy(id)
            {:ok, %SchemaModule{}}

            iex> SchemaModule.destroy(%SchemaModule{})
            {:ok, %SchemaModule{}}

        """
        def destroy(id) do
          find!(id)
          |> get_repo().delete()
        end
      end
    end
end
