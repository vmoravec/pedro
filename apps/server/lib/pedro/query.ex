defmodule Pedro.Query do
  use GenServer

  def query block do
    IO.puts "Running query.."
    block.()
  end

  def start_link do
    GenServer.start_link(__MODULE__, name: :query)
  end
end
