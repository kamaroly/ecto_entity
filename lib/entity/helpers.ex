defmodule Entity.Helpers do

  @doc """
  Returns the first loaded app name
  ## Examples
    iex> Entity.AppHelpers.app_name
    iex> :entity
  """
  def app_name do
     {app_name, _, _} = Enum.at(Application.loaded_applications, 0)

     app_name
  end

  def get_repo do
     Application.get_env(app_name(), :ecto_repos, [])
     |> Enum.at(0)
  end
end
