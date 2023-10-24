defmodule EntityTest do
  use ExUnit.Case
  alias Entity.AppHelpers

  test "app_name returns OTP app name as an atom" do
    assert AppHelpers.app_name == :entity
  end

  test "We can get the repo module to work with" do
    assert AppHelpers.get_repo == Entity.Repo
  end
end
