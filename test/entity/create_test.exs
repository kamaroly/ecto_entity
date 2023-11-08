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

  test "create_many/1 inserts multiple entries to db at once" do
    attrs = [
      %{first_name: Faker.first_name(), last_name: Faker.last_name(), age: Faker.random_digit()},
      %{first_name: Faker.first_name(), last_name: Faker.last_name(), age: Faker.random_digit()},
      %{first_name: Faker.first_name(), last_name: Faker.last_name(), age: Faker.random_digit()}
    ]

    # Expect 3 Entries
    assert {:ok, %{insert_all: {_count, nil}}} = Person.insert_many(attrs)
  end

  test "insert_many/1 inserts multiple entries to db at once" do
    attrs = [
      %{first_name: Faker.first_name(), last_name: Faker.last_name(), age: Faker.random_digit()},
      %{first_name: Faker.first_name(), last_name: Faker.last_name(), age: Faker.random_digit()},
      %{first_name: Faker.first_name(), last_name: Faker.last_name(), age: Faker.random_digit()}
    ]

    # Insert many and return success query
    assert {:ok, %{insert_all: {_count, nil}}} = Person.insert_many(attrs)
  end
end
