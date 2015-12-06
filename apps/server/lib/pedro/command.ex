defmodule Pedro.Command do
  use GenServer

  def command block do
    execute(block)
  end

  def execute block do
    GenServer.call(__MODULE__, {:block, block})
  end

  def start_link do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def handle_call {:block, block}, _from, _state do
    {:reply, block.(), _state}
  end
end
