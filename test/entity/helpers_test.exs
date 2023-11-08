defmodule Entity.HelpersTest do
  use ExUnit.Case
  use Ecto.Entity.Helpers

  test "We can get the repo module to work with" do
    assert get_repo() == Ecto.Entity.Repo
  end
end
