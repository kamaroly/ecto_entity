defmodule Person do
  use Entity
  use Ecto.Schema
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

ExUnit.start()
