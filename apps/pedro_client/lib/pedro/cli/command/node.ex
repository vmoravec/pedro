defmodule PedroClient.Cli.Node do
  @moduledoc """
  Handles requests for nodes' information.
  """
  alias PedroClient.Cli.Api
  alias PedroClient.Cli.Runner
  alias PedroClient.Cli.View

  @doc """
  List all nodes
  """
  def list params do
    case params[:protocol] do
      :api -> Api.get("/nodes", params) |> to_response(params)
      :rpc -> Runner.run_service(params[:node], :ListNodes, [params]) |> to_response(params)
    end
    |> View.Node.list(params)
    |> run_exit(params)
  end

  def status params do
    node = :"#{params[:node_name]}@#{params[:hostname]}"
    if params[:api] do
      Api.get("/status", params)
    else
      Runner.run_service(node, :ShowNodeStatus, [params])
    end
    |> View.Node.status(params)
    |> run_exit(params)
  end

  def run_exit result, params do
    if result do
      IO.puts "Response was not successful"
      System.halt 1
    else
      System.halt 0
    end
  end

  def to_response data, params do
    IO.inspect params
    IO.inspect data
    data
  end

end
