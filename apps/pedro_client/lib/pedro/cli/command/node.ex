defmodule PedroClient.Cli.Command.Node do
  alias PedroClient.Cli.Api
  alias PedroClient.Cli.Runner
  alias PedroClient.Cli.View

  def list params do
    # 1. Detect default local node "pedro-server"
    # 2. Get info from the local server about the default node
    # 3. Load the data from the default server about all other nodes (
    #    this data is stored in a mnesia table somewhere on the default node)
    # 4. Render output in 2 batches:
    #    * first one is info about the default server
    #    * the rest is from the configuration and runtime of the default server

    node = :"#{params[:node_name]}@#{params[:hostname]}"
    if params[:api] do
      Api.get("/nodes", params)
    else
      Runner.run(node, ListNodes, [params])
    end
    |> View.Node.list(params)
  end

  def status params do
    node = :"#{params[:node_name]}@#{params[:hostname]}"
    if params[:api] do
      Api.get("/status", params)
    else
      Runner.run(node, ShowNodeStatus, [params])
    end
    |> View.Node.status(params)
  end

end
