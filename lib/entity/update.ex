defmodule Entity.Update do
  import Entity.Helpers
  use Entity.Read, only: [find: 1]
  defmacro __using__(_) do
    quote do

    def update(id, %{} = attrs) when not is_map(id) do
      find(id)
      |> __MODULE__.changeset(attrs)
      |> update_schema()
    end
    def update(__MODULE__ = schema, %{} = attrs) do

      schema
      |> __MODULE__.changeset(attrs)
      |> update_schema()
    end

    defp update_schema(query) do
        query
        |> get_repo().update()
    end
  end
end

end
