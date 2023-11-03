defmodule Ecto.Entity.Repo.Migrations.CreatePersonAddressesTable do
  use Ecto.Migration

  def change do
    create table(:person_addresses) do
      add :name, :string
      add :person_id, references(:people, on_delete: :nothing), null: false
      timestamps()
    end

    create unique_index(:person_addresses, :person_id)
  end
end
