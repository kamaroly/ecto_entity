defmodule Ecto.Entity.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do

    create table(:posts) do
      add :title, :string
      add :body, :text
      add :person_id, references(:people, on_delete: :nothing)

      timestamps()
    end
  end
end
