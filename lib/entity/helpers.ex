defmodule Entity.Helpers do

  @doc """
  Returns the first loaded app name
  ## Examples
    iex> Entity.AppHelpers.app_name
    iex> :entity
  """
  def app_name, do: :entity

  def get_repo do
    Application.get_env(app_name(), :ecto_repos, [])
    |> case do
      [repo] -> repo
      _ -> raise "Multiple repos are not supported right now."
    end
  end
end
