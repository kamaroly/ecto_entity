defmodule Entity.HelpersTest do
  use ExUnit.Case
  alias Ecto.Entity.Helpers

  test "We can get the repo module to work with" do
    assert Helpers.get_repo() == Ecto.Entity.Repo
  end
end
