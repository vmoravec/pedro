defmodule Pedro.Cli.Node do
  require Logger

  def list params do
  end

  def status params do
    IO.puts "CLI options: #{inspect params}"
    node = :"#{params[:node_name]}@#{params[:hostname]}"
    if params[:api] do
      Pedro.Api.get("/status", params)
      |> render(params)
    else
      Pedro.Runner.run(node, NodeStatusService, [params])
      |> render(params)
    end

    #TODO now lookup the node that was specified in the list of nodes
    # that will be created before this event from either database or a config file
    # and check if the node name exists there. If yes, pick the node and work on it.
    # There should be a restriction applied to the unique node names (aliases) on 
    # a single node to make handling them easier for the user
  end

  defp get_node_name params do
    case params[:values] do
      nil -> nil
      node_name -> node_name
      [node_name | _] -> node_name
    end
  end

  defp render response, data do
  end

end
