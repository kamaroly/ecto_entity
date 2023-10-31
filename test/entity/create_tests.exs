defmodule Entity.CreateTests do
  use ExUnit.Case
  use Factory
  alias Person

  # CREATING TESTS
  # ===============
  test "create/1 stores data." do
    assert {:ok, %Person{}} = Person.create(person_attrs())
  end

  test "insert/1 stores data." do
    assert {:ok, %Person{}} = Person.insert(person_attrs())
  end
end
