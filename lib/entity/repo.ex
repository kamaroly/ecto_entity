defmodule Ecto.Entity.Repo do
  use Ecto.Repo,
    otp_app: :ecto_entity,
    adapter: Ecto.Adapters.MyXQL
end
