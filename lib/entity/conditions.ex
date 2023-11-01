defmodule Ecto.Entity.Conditions do
  import Ecto.Query

  defmacro __using__(_) do
    quote do

      def where(field, value) when is_binary(field) do
        String.downcase(field)
        |> String.to_atom()
        |> __MODULE__.where(value)
      end

      def where(field,  value) do
        from(u in __MODULE__, where: field(u, ^field) == ^value)
      end

    end
  end
end
