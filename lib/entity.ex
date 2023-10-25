defmodule Entity do
  @moduledoc """
  Documentation for `Entity`.
  """
  defmacro __using__(_) do
    quote do
      use Entity.{
        Create,
        Read,
        Update,
        Delete,
        Association
      }
    end
  end
end
