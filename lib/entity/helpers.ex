defmodule Ecto.Entity.Helpers do
  @doc """
  Get the repo to use
  """

  # ------------------------------------------
  # -------- Functions to imports ------------
  # ------------------------------------------

  defmacro __using__(_) do
    quote do
      def app_name, do: Application.get_env(:ecto_entity, :app_name)

      def get_repo do
        Application.get_env(app_name(), :ecto_repos, [])
        |> case do
          [repo] -> repo
          _ -> raise "Multiple repos are not supported right now."
        end
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
      @doc """
      Determine whether current module has a specific function.

      # Example
        iex(1)> Person.has_function?(:changeset, 2)
        true
        iex(2)> Person.has_function?(:changeseter, 2)
        false
      """
      def has_function?(function_name, arity) when is_atom(function_name) and is_integer(arity) do
        module_has_function?(__MODULE__, function_name, arity)
      end

      @doc """
      Determines whether the provided module has a specific function
      """
      def module_has_function?(module_name, function_name, arity) do
        :erlang.function_exported(module_name, function_name, arity)
      end
    end
  end
end
