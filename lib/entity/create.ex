defmodule Entity.Create do
  import Entity.Helpers
  defmacro __using__(_) do
    quote do
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
    end
  end
end
