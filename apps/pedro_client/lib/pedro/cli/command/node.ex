defmodule PedroClient.Cli.Node do
  @moduledoc """
  Handles requests for nodes' information.
  """
  alias PedroClient.Cli.Api
  alias PedroClient.Cli.RemoteService
  alias PedroClient.Cli.View

  @doc """
  List all nodes
  """
  def list env do
    response = case env[:protocol] do
      :api ->
        Api.get("/nodes", env)
        |> to_response(env)
      :rpc ->
        RemoteService.run(env, :ListNodes)
        |> to_response(env)
    end
    response |> View.Node.list
    response |> run_exit
  end

  def status env do
    response = case env[:protocol] do
      :api ->
        Api.get("/status", env)
        |> to_response(env)
      :rpc ->
        RemoteService.run(env, :ShowNodeStatus)
        |> to_response(env)
    end
    response |> View.Node.status
    response |> run_exit
  end

  def run_exit response do
    case response do
      %{ok?: true } ->
        System.halt 0
      %{ok?: false, message: message} ->
        IO.puts message
        System.halt 1
    end
  end

  defp to_response data, env do
    case env[:protocol] do
      :api -> handle_http_response(data)
      :rpc -> handle_rpc_response(data, env)
    end
  end

  defp handle_rpc_response data, env do
    case data do
      {:error, {:EXIT, error}} ->
        %{ok?: false, message: "Error, sure it's a bug: #{inspect error}",  data: error}
      {:error, :nodedown } ->
        %{ok?: false, message: "Node #{env[:server]} is not available", data: nil}
      {:error, status } ->
        %{ok?: false, message: "ERROR with status #{inspect status}", data: data}
      {:ok, response } ->
        %{ok?: true, data: response}
    end
  end

  defp handle_http_response response do
    case response do
      { %HTTPoison.Response{}, _env } ->
        decode_http_response(response)
      { %HTTPoison.Error{}, _env } ->
        %{ok?: false, data: response, message: decode_failed_api(response)}
    end
  end

  defp decode_http_response response do
    {data, env} = response
    cond do
      data.status_code > 200 ->
        %{ok?: false, error?: true, message: "Problem with API request at #{env[:request_url]},
        return status: #{data.status_code}", data: data}
    end
  end

  defp decode_failed_api response do
    messages = ["\nAPI request failed."]
    case response do
      { %HTTPoison.Error{reason: :econnrefused}, env } ->
        messages = [ "Could not connect to node api at '#{env[:request_url]}'" | messages ]
    end
    Enum.join(messages)
  end

end
