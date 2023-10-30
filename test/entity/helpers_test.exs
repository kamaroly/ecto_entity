defmodule EntityTest do
  use ExUnit.Case
  alias Entity.Helpers

  test "app_name returns OTP app name as an atom" do
    assert Helpers.app_name() == :entity
  end

  test "We can get the repo module to work with" do
    assert Helpers.get_repo() == Entity.Repo
  end
end
