defmodule Entity.AppHelpersTest do
  use ExUnit.Case
  alias Person # Represent Any Schema using Ecto

  # TEST HELPER FUNCTIONS
  def person_attrs do
    %{
      first_name: Faker.first_name,
      last_name: Faker.last_name,
      age: Faker.random_digit
    }
  end

  def seed_people(count \\ 1) do
    1..count
    |> Enum.each(fn _ -> Person.insert(person_attrs()) end)
  end

  test "gets ecto repo" do
    assert Person.get_repo == Entity.Repo
  end

  test "create/1 stores data." do
    assert {:ok, %Person{}} = Person.create(person_attrs())
  end

  test "insert/1 stores data." do
    assert {:ok, %Person{}} = Person.insert(person_attrs())
  end

  test "truncate/0 empties table" do
    # Create records
    seed_people(5)
    # Truncate the table
    assert {:ok, _} = Person.truncate()
  end

  # Many records are previous created, so no need to seed database
  test "first/0 returns first records" do
    seed_people(10)
    assert Person.first.id == 1
  end

  test "find!/1 raises Ecto.NoResultsError for non-existing entity" do
    assert_raise Ecto.NoResultsError, fn ->
      Person.find!(1999999999)
    end
  end

  test "Retrieves the last record in the table" do
    # Seed database
    Person.create(person_attrs())
    Person.create(person_attrs())

    # Assert
    assert %Person{} = Person.last
    assert Person.last.id > Person.first.id
  end

  test "Retrieves a record by id" do
    seed_people(4)

    assert %Person{} = Person.find(1)
    assert Person.find(1).id == 1
  end
end
