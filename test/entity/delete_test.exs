defmodule Entity.DeleteTests do
  use ExUnit.Case
  use Factory
  alias Person

  # CREATING TESTS
  # ===============
  test "delete/1 deletes 1 record." do
    seed_people(2)

    assert {:ok, _} = Person.delete(1)
  end

  test "delete/1 deletes multiple entries at once." do
    Person.truncate()
    seed_people(40)
    assert {count, nil} = Person.delete([1, 2, 3, 4, 5, 6])
  end

  test "destroy/1 removes a record from database." do
    seed_people(4)
    person = Enum.at(Person.take(4), 2)
    assert {:ok, %Person{}} = Person.delete(person.id)
  end

  test "delete_except/1 deletes entries with exception." do
    Person.truncate()
    seed_people(4)

    assert {count, nil} = Person.delete_except(4)
    assert 4 == Person.first().id
  end

  test "delete_except/1 deletes entries with exception provided." do
    Person.truncate()

    seed_people(4)

    assert {count_of_entries, nil} = Person.delete_except([2, 3])
  end

  test "truncate/0 truncates the entire table." do
    seed_people(20)
    Address.truncate()
    assert {:ok, _} = Person.truncate()
  end
end
