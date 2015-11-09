defmodule Pedro.Env do
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
    |> update_node_name
  end

  def load_pedrorc do
    :yamerl_constr.file("#{:os.getenv("HOME")}/.pedrorc")
  end

  defp extract_switches attrs, switches do
    Keyword.merge(attrs, switches)
  end

  defp extract_values attrs, values do
    Keyword.merge(attrs, values: values)
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

