defmodule Person do
  use Ecto.Entity
  use Ecto.Schema
  alias __MODULE__
  import Ecto.Changeset

  @timestamps_opts [type: :naive_datetime]

  schema "people" do
    field(:first_name, :string)
    field(:last_name, :string)
    field(:age, :integer)
    has_many(:addresses, Address)

    timestamps()
  end

  def changeset(%Person{} = person, attrs) do
    person
    |> cast(attrs, [:first_name, :last_name, :age])
  end
end
