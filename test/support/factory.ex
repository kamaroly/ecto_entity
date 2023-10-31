defmodule Factory do
  defmacro __using__(_) do
    quote do
      # TEST HELPER FUNCTIONS
      def person_attrs do
        %{
          first_name: Faker.first_name(),
          last_name: Faker.last_name(),
          age: Faker.random_digit()
        }
      end

      def seed_people(count \\ 1) do
        1..count
        |> Enum.each(fn _ -> Person.insert(person_attrs()) end)
      end
    end
  end
end
