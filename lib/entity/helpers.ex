defmodule Ecto.Entity.Helpers do
  import Ecto.Query
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
end
