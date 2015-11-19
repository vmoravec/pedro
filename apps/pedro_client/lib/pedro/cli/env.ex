defmodule PedroClient.Cli.Env do
  @default_attributes [
    node_name:     "pedro-server",
    hostname: :os.getenv("HOSTNAME"),
    api: false
  ]

  def detect_from_cli switches, command, values do
    @default_attributes
    |> extract_switches(switches)
    |> extract_values(values)
    |> extract_command(command)
    |> extract_protocol
    |> update_node_name
    |> add_node
  end

  defp add_node attrs do
    Keyword.merge(attrs, node: :"#{attrs[:node_name]}@#{attrs[:hostname]}")
  end

  defp extract_switches attrs, switches do
    Keyword.merge(attrs, switches)
  end

  defp extract_values attrs, values do
    Keyword.merge(attrs, values: values)
  end

  defp extract_protocol attrs do
    protocol = if attrs[:api] do
      :api
    else
      :rpc
    end
    Keyword.merge(attrs, protocol: protocol)
  end

  defp extract_command attrs, command do
    Keyword.merge(attrs, command: command)
  end

  defp update_node_name attrs do
    if Keyword.has_key?(attrs, :node_name) do
      attrs
    else
      Keyword.merge(attrs, node_name: get_node_name)
    end
  end

  defp get_node_name do
    :os.getenv("PEDRO_SERVER")
  end

end

