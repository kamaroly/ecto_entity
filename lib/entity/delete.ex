defmodule Ecto.Entity.Delete do
  defmacro __using__(_) do
    quote do
      import Ecto.Entity.Helpers, only: [get_repo: 0, in_ids: 1]
      use Ecto.Entity.Read, only: [find!: 1, in_ids: 1, not_in_ids: 1]

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
      def truncate, do: get_repo().query("TRUNCATE #{table_name()}", [])

      @doc """
      Deletes the a database entry from a schema module
      
      ## Examples
      
          iex> Person.delete(31)
          {:ok,
            %Person{
              __meta__: #Ecto.Schema.Metadata<:deleted, "people">,
              id: 31,
              first_name: "Roman",
              last_name: "Haag",
              age: nil
            }}
      
      """
      def destroy(ids) when is_list(ids), do: in_ids(ids) |> get_repo().delete_all()
      def destroy(id) when not is_map(id), do: find!(id) |> get_repo().delete()
      def destroy(entity) when is_map(entity), do: destroy(entity.id)

      @doc """
      Delete everything except what is provided in this list
      
      ## Examples
              iex> Person.destroy_except([6,4])
              {:ok,
              %Person{
                __meta__: #Ecto.Schema.Metadata<:deleted, "people">,
                id: 31,
                first_name: "Roman",
                last_name: "Haag",
                age: nil
              }}
      """
      def destroy_except(ids) when is_list(ids), do: not_in_ids(ids) |> get_repo().delete_all()
      def destroy_except(id), do: destroy_except([id])

      def delete(entity), do: destroy(entity)
      def delete_except(ids), do: destroy_except(ids)
    end
  end
end
