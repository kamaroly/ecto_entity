defmodule Entity.UpdateTest do
  use ExUnit.Case
  use Factory

  alias Entity.Person

  # UPDATES & Record Modifications
  test "update/2 updates a specific table record" do
    seed_people(13)

    person = Enum.random(Person.all())
    person_id = person.id
    # Update a random person
    person_attrs = %{first_name: "Kamaro", last_name: "Lambert"}
    Person.update(person.id, person_attrs)

    # Find new person
    person = Person.find(person_id)

    assert person.first_name == "Kamaro"
    assert person.last_name == "Lambert"
  end

  test "update/2 changes specific entity in db with entire object" do
    seed_people(3)

    old_person = Person.first()

    person_attr = %{first_name: Faker.first_name(), last_name: Faker.last_name()}

    new_person = Person.update(old_person, person_attr)

    assert new_person.first_name == person_attr.first_name
    assert new_person.last_name == person_attr.last_name

    assert old_person.first_name != new_person.first_name
    assert old_person.last_name != new_person.last_name
  end
end
