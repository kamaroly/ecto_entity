defmodule Entity.UpdateTest do
  use ExUnit.Case
  use Factory

  alias Person


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
end
