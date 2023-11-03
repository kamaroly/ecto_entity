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

  def get_current_time do
    NaiveDateTime.utc_now()
    |> NaiveDateTime.truncate(:second)
  end

  def put_timestamps(attrs) when is_list(attrs) do
    attrs
    |> put_timestamps(:inserted_at)
    |> put_timestamps(:updated_at)
  end

  def put_timestamps(attrs, key) when is_list(attrs) and is_atom(key) do
    Enum.map(attrs, fn row -> put_timestamp(row, key) end)
  end

  def put_timestamp(row, key) do
     Map.put(row, key, get_current_time())
  end
end
