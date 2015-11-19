defmodule PedroClient.Cli.Runner do
  use GenServer

  @timeout 5

  def start_link do
    GenServer.start_link(__MODULE__, :running, name: __MODULE__)
  end

  def run_service node, module, args do
    GenServer.call(__MODULE__, { :local, node, :"Elixir.PedroServer.Service.#{module}", :call, args })
  end

  def handle_call {:local, node, mod, fun, args}, _from, status do
    case :rpc.call(node, mod, fun, args, @timeout) do
      {:badrpc, reason } -> { :reply, {:error, reason}, :error}
      result             -> { :reply, result, :success}
    end
  end
end
