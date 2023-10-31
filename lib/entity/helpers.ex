defmodule Entity.Helpers do
  @doc """
  Get the repo to use
  """
  def get_repo do
    Application.get_env(:entity, :ecto_repos, [])
    |> case do
      [repo] -> repo
      _ -> raise "Multiple repos are not supported right now."
    end
  end

  def get_pub_sub do
    Application.get_env(:entity, :pubsub_server)
    |> case do
       nil -> raise "You must configure a Pub Sub to use this feature"
       pub_sub -> pub_sub
    end
  end
end
