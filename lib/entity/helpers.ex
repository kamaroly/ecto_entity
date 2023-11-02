defmodule Ecto.Entity.Helpers do
  @doc """
  Get the repo to use
  """
  def app_name, do: Application.get_env(:ecto_entity, :app_name)

  def get_repo do
    Application.get_env(app_name(), :ecto_repos, [])
    |> case do
      [repo] -> repo
      _ -> raise "Multiple repos are not supported right now."
    end
  end

  def generate_random_uuid do
    # 16 bytes = 128 bits
    random_bytes = :crypto.strong_rand_bytes(16)
    random_uuid = Base.encode16(random_bytes, case: :lower)
    String.replace(random_uuid, ~r/[^a-f0-9]/, "") |> String.downcase()
  end
end
