defmodule Ecto.Entity.Association do
  defmacro __using__(_) do
    quote do
      import Ecto.Entity.Helpers, only: [get_repo: 0]
      use Ecto.Entity.Read, only: [all: 0]

      # ASSOCIATIONS SECTION
      @spec load(query :: Queryable.t(), assoc :: List.t()) :: List.t()
      def load(query, assocs) when is_list(assocs) do
        query |> get_repo().preload(assocs)
      end

      def load(query, assoc) when is_atom(assoc) do
        query |> get_repo().preload(assoc)
      end

      def load(assocs) when is_atom(assocs) or is_list(assocs) do
        all() |> get_repo().preload(assocs)
      end

      def has(query, relationship), do: raise("Where has will be supported in the future version")
      def has(query, relationship), do: raise("Where has will be supported in the future version")
    end
  end
end
