defmodule Entity.DeleteTests do
  use ExUnit.Case
  use Factory
  alias Person

  # CREATING TESTS
  # ===============
  test "delete/1 deletes 1 record." do
    seed_people(1)
    assert {:ok, _} = Person.first().id |> Person.delete()
  end

  test "delete/1 deletes multiple entries at once." do
    seed_people(40)
    assert {_count, nil} = Person.delete([1, 2, 3, 4, 5, 6])
  end

  test "destroy/1 removes a record from database." do
    seed_people(4)
    person = Enum.at(Person.take(4), 2)
    assert {:ok, %Person{}} = Person.delete(person.id)
  end

  test "delete_except/1 deletes entries with exception." do
    seed_people(4)
    assert {count, nil} = Person.delete_except(4)
    assert is_integer(count)
  end

  test "delete_except/1 deletes entries with exception provided." do
    seed_people(4)
    assert {count_of_entries, nil} = Person.delete_except([2, 3])
    assert is_integer(count_of_entries)
  end

  test "truncate/0 truncates the entire table." do
    Person.get_repo().transaction(fn  ->
      Person.disable_foreign_key_checks()
      assert is_map(Person.truncate())
    end)
  end
end
