defmodule Entity.Helpers do

  @doc """
  Returns the first loaded app name
  ## Examples
    iex> Entity.AppHelpers.app_name
    iex> :entity
  """
  def app_name do
    {_, app_name} = Entity.MixProject.project |> Enum.at(0)
    app_name
  end

  @doc """
  Get the repo to use
  """
  def get_repo do
    Application.get_env(app_name(), :ecto_repos, [])
    |> case do
      [repo] -> repo
      _ -> raise "Multiple repos are not supported right now."
    end
  end

  def get_pub_sub do
    Application.get_env(Entity.Helpers.app_name, :pubsub_server, nil)
    |> case do
       nil -> raise "You must configure a Pub Sub to use this feature"
       pub_sub -> pub_sub
    end
  end
end
