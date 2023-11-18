defmodule Ecto.Entity.PubSub do
  defmacro __using__(_) do
    quote do
      @doc """
      Returns event name as an atom

      ## Example
        iex> Module.get_event_name("updated")
        iex> :user_updated

      """
      def get_event(event_name) do
        get_name() <> "_" <> event_name
        |> String.to_atom()
      end

      @doc """
      Returns current module name as a string
      ## Example
          iex> Module.get_name
          iex> "user"
      """
      def get_name() do
        Phoenix.Naming.resource_name(__MODULE__)
      end

      def subscribe do
        Phoenix.PubSub.subscribe(get_pub_server(), get_name())
      end

      @doc false
      def broadcast({:error, _reason} = error, _event), do: error
      def broadcast({:ok, resource}, event) do
        case Phoenix.PubSub.broadcast(get_pub_server(), get_name(), {event, resource}) do
          :ok -> {:ok, resource}
           _ ->  IO.puts "Configure you pubsub in `config/config.exs > config :ecto_entity, ecto_pub_sub: Ecto.Entity.PubSub`"
        end
      end

      def maybe_broadcast_event(results, event_name) do
        __MODULE__.broadcast(results, get_event(event_name))
      end
    end
  end
end
