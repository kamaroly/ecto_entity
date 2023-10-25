defmodule Entity.Association do

  import Entity.Helpers, only: [get_repo: 0]
  use Entity.Read, only: [all: 0]
    defmacro __using__(_) do
    quote do

  # ASSOCIATIONS SECTION
  @spec load(query :: Queryable.t(), assoc :: List.t) :: List.t()
  def load(query, assocs) when is_list(assocs) do
    query |> get_repo().preload(assocs)
  end

  def load(query, assoc) when is_atom(assoc) do
    query |> get_repo().preload(assoc)
  end

  def load(assocs) when is_atom(assocs) or  is_list(assocs) do
    all() |> get_repo().preload(assocs)
  end
end
end
end
