defmodule Person do
  use Ecto.Schema
  use Ecto.Entity
  import Ecto.Changeset

  @timestamps_opts [type: :naive_datetime]

  schema "people" do
    field(:first_name, :string)
    field(:last_name, :string)
    field(:age, :integer)
    has_many(:addresses, Address)

    timestamps()
  end

  def changeset(person, attrs) do
    person
    |> cast(attrs, [:first_name, :last_name, :age])
  end
end
