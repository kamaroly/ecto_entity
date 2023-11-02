defmodule Ecto.Entity.Changes do
  defmacro __using__(_) do
    quote do
      defp module_change(attrs) do
        __MODULE__.__struct__()
        |> __MODULE__.changeset(attrs)
      end
    end
  end
end
