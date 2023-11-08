defmodule Ecto.Entity.Conditions do
  import Ecto.Query

  defmacro __using__(_) do
    quote do
      def where(field, value) when is_atom(field) do
        from(u in __MODULE__, where: field(u, ^field) == ^value)
      end

      def where(field, value) when is_binary(field) do
        String.downcase(field)
        |> String.to_atom()
        |> __MODULE__.where(value)
      end

      def where_all(field, value), do: __MODULE__.where(field, value) |> all()

      def where_first(field, value) do
        __MODULE__.where(field, value) |> first() |> get_repo().one()
      end


      def in_ids(ids) when is_list(ids), do: from(p in __MODULE__, where: p.id in ^ids)
      def in_ids(id), do: __MODULE__.in_ids([id])

      def not_in_ids(ids) when is_list(ids), do: from(p in __MODULE__, where: p.id not in ^ids)
      def not_in_ids(id), do: not_in_ids([id])
    end
  end
end
