defmodule PedroClient.Cli do
  @moduledoc """
  Handle command line parsing and dispatch functions
  Modules nested in the Pedro.Cli namespace contain command implementation
  """

  alias PedroClient.Cli.Env

  def main(argv) do
    parse_args(argv)
  end

  def parse_args(argv) do
    result = OptionParser.parse(
      argv,
      switches: [
        help:   :boolean,
        node_name: :string,
        use_api: :boolean
      ],
      aliases:  [
        h: :help,
        n: :node_name,
        p: :use_api
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
        String.to_atom("Elixir.PedroClient.Cli.Command.#{String.capitalize(module)}"),
        String.to_atom(fun),
        [Env.detect_from_cli(switches, command, values)]
      )
    rescue
      e in UndefinedFunctionError -> IO.puts("Unknown command '#{command}'\n #{inspect e}")
    end
  end

end
