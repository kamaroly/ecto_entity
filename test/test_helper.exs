defmodule Person do
  use Entity
  use Ecto.Schema
  alias __MODULE__
  import Ecto.Changeset

  schema "people" do
    field :first_name, :string
    field :last_name, :string
    field :age, :integer
  end

  def changeset(%Person{} = person, attrs) do
    person
    |> cast(attrs, [:first_name, :last_name, :age])
  end
end

defmodule Factory do
  defmacro __using__(_) do
    quote do
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
    end
  end
end

ExUnit.start()
