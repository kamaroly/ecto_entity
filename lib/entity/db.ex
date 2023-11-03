defmodule Ecto.Entity.DB do
  defmacro __using__(_) do
    quote do
      import Ecto.Entity.Helpers
      alias Ecto.Adapters.SQL

      @doc """
      Run RAW SQL queries against database

      ## Example
      iex(1)> Ecto.Entity.raw("SELECT current_timestamp")
      %MyXQL.Result{
      columns: ["current_timestamp"],
      connection_id: 233,
      last_insert_id: nil,
      num_rows: 1,
      rows: [[~N[2023-11-03 20:02:48]]],
      num_warnings: 0
      }
      """
      def raw(query, parameters \\ []) do
        SQL.query!(get_repo(), query, parameters)
      end
    end
  end
end
