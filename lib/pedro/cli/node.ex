defmodule Pedro.Cli.Node do
  require Logger

  def list options do
  end

  def status options do
    node_name = :os.getenv("PEDRO_SERVER")
    node_name = case Keyword.fetch(options, :values) do
      {:ok, values} -> List.first(values)
    end
    if node_name, do: options = Keyword.merge(options, node: node_name)

    Logger.info "CLI options: #{inspect options}"
    Logger.info Node.get_cookie
    Logger.info options[:remote]
    node_name = :"#{options[:node]}@#{options[:localhost]}"
    if options[:remote] do
      # Pedro.Api.get(node_name, "/status")
      IO.puts "Sending http request to remote pedro about his status.."
    else
      Pedro.Runner.local(node_name, NodeStatusServices, [])
    end
    #TODO now lookup the node that was specified in the list of nodes
    # that will be created before this event from either database or a config file
    # and check if the node name exists there. If yes, pick the node and work on it.
    # There should be a restriction applied to the unique node names (aliases) on 
    # a single node to make handling them easier for the user
  end

end
