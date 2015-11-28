defmodule Pedro.Client.Cli do
  @moduledoc """
  Handle command line parsing and dispatch functions
  Modules nested in the Pedro.Cli namespace contain command implementation
  """

  alias Pedro.Client.Cli.Env

  def main(argv) do
    parse_args(argv)
  end

  def parse_args(argv) do
    result = OptionParser.parse(
      argv,
      switches: [
        help:   :boolean,
        node_name: :string,
        use_api: :boolean,
        verbose: :boolean
      ],
      aliases:  [
        h: :help,
        n: :node_name,
        p: :use_api,
        v: :verbose
      ]
    )

    case result do
      { [ help: true ], _, _ }
        -> help
      { [], ["help"], [] }
        -> help
      { [], ["help", command], [] }
        -> help(command)
      { [], ["h"], [] }
        -> help
      { [], ["h", command], [] }
        -> help(command)
      {[], [], []}
        -> help
      { switches, commands, _ }
        -> run_action(switches, commands)

      _ -> help
    end
  end

  def help do
    IO.puts "  pedro node.list               # List all known nodes"
    IO.puts "  pedro node.status NODE_NAME   # Show status info about a specific node"
  end

  def help command do
    IO.puts command
    help
  end

  defp run_action switches, commands do
    [ command | values ] = commands
    [ module, fun ] = String.split(command, ".")

    if fun == nil do
      fun = module
      module = "Default"
    end

    try do
      Kernel.apply(
        String.to_atom("Elixir.Pedro.Client.Cli.#{String.capitalize(module)}"),
        String.to_atom(fun),
        [Env.detect_from_cli(switches, command, values)]
      )
    rescue
      e in UndefinedFunctionError -> IO.puts("Unknown command '#{command} error #{inspect e}'\n")
    end
  end

end
