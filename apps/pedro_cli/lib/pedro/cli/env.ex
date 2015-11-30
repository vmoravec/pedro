defmodule Pedro.Cli.Env do
  @default_attributes [
    server_name: "pedro-server",
    server_host: :os.getenv("HOSTNAME"),
    api_url: "localhost",
    api: false
  ]

  def detect_from_cli switches, command, values do
    @default_attributes
    |> extract_switches(switches)
    |> extract_values(values)
    |> extract_command(command)
    |> extract_protocol
    |> update_server_attributes
    |> update_server_api
  end

  defp extract_switches attrs, switches do
    Keyword.merge(attrs, switches)
  end

  defp extract_values attrs, values do
    Keyword.merge(attrs, values: values)
  end

  defp extract_protocol attrs do
    protocol = if attrs[:api], do: :api, else: :rpc
    Keyword.merge(attrs, protocol: protocol)
  end

  defp extract_command attrs, command do
    Keyword.merge(attrs, command: command)
  end

  defp update_server_api attrs do
    case :os.getenv("PEDRO_API") do
      "" ->
        attrs
      false ->
        attrs
      [] ->
        attrs
      url ->
        Keyword.merge(attrs, api_url: to_string(url))
    end
  end

  defp update_server_attributes attrs do
    server = to_string(:os.getenv("PEDRO_SERVER"))
    if String.length(server) > 0 do
      unless Regex.match?(~r/@/, server), do: raise "Wrong server name: '#{server}'"
      if server do
        [server_name, server_host] = String.split(server, "@")
        Keyword.merge(attrs,
          server_name: server_name,
          server_host: server_host,
          server: :"#{server}"
        )
      else
        Keyword.merge(attrs, server: :"#{attrs[:server_name]}@#{attrs[:server_host]}")
      end
    else
      Keyword.merge(attrs, server: :"#{attrs[:server_name]}@#{attrs[:server_host]}")
    end
  end
end

