defmodule Entity.EntityTest do
  use ExUnit.Case
  use Factory
  alias Person

  # HELPERS
  test "table_name/0 returns table name" do
    assert Person.table_name() == "people"
  end

  # READING TESTS
  # =============
  test "first/0 returns first records" do
    person = seed_people(10) |> Enum.at(0)
    assert Person.first().id == 1
  end

  test "first!/1 raises Ecto.NoResultsError for non-existing entity" do
    Person.truncate_without_key_checks()
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
    person = Person.all() |> Enum.random()

    assert %Person{} = Person.find(person.id)
    assert Person.find(person.id).id == person.id
  end

  test "find/1 retrieves many records when provided with array of ids" do
    Person.truncate_without_key_checks()
    seed_people(4)
    people = Person.find([3, 4])

    assert Enum.count(people) == 2
  end

  test "find!/1 raises Ecto.NoResultsError for non-existing entity" do
    assert_raise Ecto.NoResultsError, fn ->
      Person.find!(1_999_999_999)
    end
  end

  test "all/1 returns all records in a table" do
    Person.truncate_without_key_checks()
    seed_people(20)
    assert Person.count() == 20
  end

  test "take/1 returns the  first x records" do
    Person.truncate_without_key_checks()
    seed_people(50)
    assert 13 == Enum.count(Person.take(13))
  end

  test "count/0 returns a number of records in DB" do
    Person.truncate_without_key_checks()
    seed_people(2)
    assert Person.count() == 2
  end

  test "size/0 returns a number of table records" do
    assert is_integer(Person.size())
    assert Person.size() > 0
  end

  test "except/1 returns records except ones matching pro" do

    Person.get_repo().transaction(fn  ->
      Person.disable_foreign_key_checks()
      Person.truncate_without_key_checks()
    end)

    seed_people(3)
    person = Person.except([1, 2]) |> Enum.at(0)
    assert person.id == 3
  end

  test "except/1 returns correct records when passed one identifier" do
    results =
      Person.except(1)
      |> Enum.filter(fn item -> item.id == 1 end)

    assert Enum.empty?(results)
  end
end
