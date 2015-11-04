defmodule Pedro.Cli do
  @moduledoc """
  Handle command line parsing and dispatch functions
  Modules nested in the Pedro.Cli namespace contain command implementation
  """

  def main(argv) do
    parse_args(argv)
  end

  def parse_args(argv) do
    result = OptionParser.parse(
      argv,
      switches: [
        help:   :boolean,
        local:  :boolean,
        node_name: :string
      ],
      aliases:  [
        h: :help,
        l: :local,
        n: :node_name
      ]
    )

    case result do
      { [ help: true ], _, _ }
        -> help

      {[], [], []}
        -> help

      { switches, commands, _ }
        -> run_action(switches, commands)

      _ -> help
    end
  end

  def help do
    IO.puts "Pedro help: comes soon"
  end

  defp run_action switches, commands do
    [ command | values ] = commands
    [ module, fun ] = String.split(command, ".")
    try do
      Kernel.apply(
        String.to_atom("Elixir.Pedro.Cli.#{String.capitalize(module)}"),
        String.to_atom(fun),
        [resolve_command(switches, command, values)]
      )
    rescue
      e in UndefinedFunctionError -> IO.puts("Unknown command '#{command}'\n #{e}")
    end
  end

  @default_attributes [
    node:     "pedro-server",
    localhost: :os.getenv("HOSTNAME"),
    remote:   false
  ]

  defp resolve_command switches, command, values do
    attributes = @default_attributes
    if Keyword.has_key?(switches, :node_name) do
      attributes = Keyword.merge(attributes, node: switches[:node_name])
    end

    attributes = Keyword.merge(attributes, remote: switches[:remote])
    attributes = Keyword.merge(attributes, values: values)
    attributes
  end

end
