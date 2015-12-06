defmodule Pedro.Cli.RemoteService do
  use GenServer

  @timeout 5

  def start_link do
    GenServer.start_link(__MODULE__, :running, name: __MODULE__)
  end

  def run env, module do
    GenServer.call(__MODULE__, {env, :"Elixir.Pedro.Server.Service.#{module}"})
  end

  def handle_call {env, module}, _from, status do
    case :rpc.call(env[:server], module, :call, [env], @timeout) do
      {:badrpc, reason } -> { :reply, {:error, reason}, :error}
      result             -> { :reply, result, :success}
    end
  end
end
