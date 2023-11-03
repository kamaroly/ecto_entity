defmodule Address do
  use Ecto.Entity
  use Ecto.Schema
  import Ecto.Changeset

  schema "addresses" do
    field(:name, :string)
    belongs_to(:person, Person)

    timestamps()
  end

  def changeset(address, attrs) do
    address
    |> cast(attrs, [:name])
  end
end
