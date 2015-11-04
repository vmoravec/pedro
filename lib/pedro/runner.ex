defmodule Pedro.Runner do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, :running, name: __MODULE__)
  end

  def local node, func, args do
    IO.inspect GenServer.call(__MODULE__, { :local, node, func, args })
  end

  def http mod, func, args do
    GenServer.call(__MODULE__, { :http, mod, func})
  end

  def handle_call {:local, node, func, args}, _from, status do
    Node.connect(node)
    e = Node.spawn_link(node, func)
    { :reply, {:ok, {:pid, e}}, :success }
  end

 #def handle_call :http, _from, _ do
 #  # Use http
 #  { :reply, {:ok, {}}, :success }
 #end
  # IO.puts "Pedro is saying"
  # IO.puts inspect argv
  # pid = Node.spawn @node, fn -> IO.inspect(Node.self) end
  # IO.inspect :erlang.group_leader
end
