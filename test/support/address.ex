defmodule Address do
  use Ecto.Schema
  use Ecto.Entity
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
