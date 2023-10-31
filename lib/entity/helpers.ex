defmodule Entity.Helpers do
  def get_repo do
    Application.get_env(:entity, :ecto_repos, [])
    |> case do
      [repo] -> repo
      _ -> raise "Multiple repos are not supported right now."
    end
  end
end
