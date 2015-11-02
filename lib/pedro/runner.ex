defmodule Pedro.Runner do
  use GenServer

  @pedro_server "pedro-server"
  @hostname     :os.getenv("HOSTNAME")
  @node :"#{@pedro_server}@#{@hostname}"

  def start_link do
    GenServer.start_link(__MODULE__, :running, name: __MODULE__)
  end

  def local node, mod, func, args do
    GenServer.call(__MODULE__, { :local, node, mod, func, args })
  end

  def http mod, func, args do
    GenServer.call(__MODULE__, { :http, mod, func})
  end

  def handle_call {:local, node, mod, func, args}, _from, status do
    e = Node.spawn(:"#{node}@#{@hostname}", mod, func, args)
    { :reply, {:ok, {}}, :success }
  end

  def handle_call :http, _from, _ do
    # Use http
    { :reply, {:ok, {}}, :success }
  end
  # IO.puts "Pedro is saying"
  # IO.puts inspect argv
  # pid = Node.spawn @node, fn -> IO.inspect(Node.self) end
  # IO.inspect :erlang.group_leader
end
