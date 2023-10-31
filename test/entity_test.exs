defmodule Entity.EntityTest do
  use ExUnit.Case
  use Factory
  alias Person

  # HELPERS
  test "table_name/0 returns table name" do
    assert Person.table_name() == "people"
  end

  # DELETING TESTS
  # ================
  test "truncate/0 empties table" do
    # Create records
    seed_people(5)
    # Truncate the table
    assert {:ok, _} = Person.truncate()
  end

  # READING TESTS
  # =============
  test "first/0 returns first records" do
    seed_people(10)
    assert Person.first().id == 1
  end

  test "first!/1 raises Ecto.NoResultsError for non-existing entity" do
    Person.truncate()

    assert_raise Ecto.NoResultsError, fn ->
      Person.first!()
    end
  end

  test "last/0 retrieves the last record in the table" do
    # Seed database
    seed_people(2)

    # Assert
    assert %Person{} = Person.last()
    assert Person.last().id > Person.first().id
  end

  test "find/1 retrieves a record by id" do
    seed_people(4)

    assert %Person{} = Person.find(1)
    assert Person.find(1).id == 1
  end

  test "find!/1 raises Ecto.NoResultsError for non-existing entity" do
    assert_raise Ecto.NoResultsError, fn ->
      Person.find!(1_999_999_999)
    end
  end

  test "all/1 returns all records in a table" do
    count = 20

    Person.truncate()
    seed_people(count)

    assert Enum.count(Person.all()) == count
  end

  test "take/1 returns the  first x records" do
    Person.truncate()
    seed_people(50)
    assert 13 == Enum.count(Person.take(13))
  end

  test "count/0 returns a number of records in DB" do
    Person.truncate()
    seed_people(98)

    assert Person.count() == 98
  end

  test "size/0 returns a number of table records" do
    Person.truncate()
    seed_people(20)

    assert Person.size() == 20
  end
end
