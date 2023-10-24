defmodule Entity.Repo do
  use Ecto.Repo,
    otp_app: :entity,
    adapter: Ecto.Adapters.MyXQL
end
