defmodule Pedro.Cli do
  @moduledoc """
  Handle command line parsing and dispatch functions
  """

  def main(argv) do
    parse_args(argv)
  end

  def parse_args(argv) do
    result = OptionParser.parse(
      argv,
      switches: [
        help:   :boolean,
        remote: :boolean
      ],
      aliases:  [
        h: :help,
        r: :remote
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

  def run_action switches, commands do
    [ command | values ] = commands
    [ module, fun ] = String.split(command, ".")
    module_name = String.to_atom("Elixir.Pedro.Cli.#{String.capitalize(module)}")
    Kernel.apply(module_name, String.to_atom(fun), [values])
  end

end
