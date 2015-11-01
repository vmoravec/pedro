defmodule Pedro.Commander do
  use GenServer

  @pedro_server "pedro-server"
  @hostname     :os.getenv("HOSTNAME")
  @node :"#{@pedro_server}@#{@hostname}"

  def start_link do
    Node.connect @node
    IO.inspect Node.list
    GenServer.start_link(__MODULE__, :running, name: __MODULE__)
  end

  def execute mod, func do
    GenServer.call(__MODULE__, { :local, mod, func})
  end

  def handle_call {:local, mod, func}, _from, status do
    IO.inspect mod
    IO.inspect func
    e = Node.spawn(@node, Pedro.Cli.Node, :list, [])
    IO.inspect e
    { :reply, {:local, {}}, :success }
  end

  def handle_call :remote, _from, _ do
    { :reply, {:remote, {}}, :success }
  end
  # IO.puts "Pedro is saying"
  # IO.puts inspect argv
  # pid = Node.spawn @node, fn -> IO.inspect(Node.self) end
  # IO.inspect :erlang.group_leader
end
