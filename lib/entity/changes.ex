defmodule Ecto.Entity.Changes do
  defmacro __using__(_) do
    quote do
      import Ecto.Entity.Helpers

      @doc """
      Get the current module change
      """
      def schema_change(attrs) do

        case __MODULE__.has_function?(:changeset, 2) do
          true -> get_struct() |> __MODULE__.changeset(attrs)
          _ -> raise "You must implement changeset in the #{__MODULE__} schema to perform this action"
        end

      end

      def get_struct do
        __MODULE__.__struct__()
      end

      def put_inserted_at(attrs), do: put_timestamp_column(attrs, :inserted_at)

      def put_updated_at(attrs), do: put_timestamp_column(attrs, :updated_at)

      def put_timestamp_column(attrs, column) when is_atom(column) do
        case Map.has_key?(get_struct(), column) do
          true -> put_timestamps(attrs, column)
          _ -> attrs
        end
      end
    end
  end
end
