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

  defp run_action switches, commands do
    [ command | values ] = commands
    [ module, fun ] = String.split(command, ".")
    try do
      Kernel.apply(
        String.to_atom("Elixir.Pedro.Cli.#{String.capitalize(module)}"),
        String.to_atom(fun),
        [resolve(switches, command, values)]
      )
    rescue
      e in UndefinedFunctionError -> IO.puts("Command does not exist: #{inspect e}")
    end
  end

  defp resolve switches, command, values do
    switches |> resolve_command(command, values)
  end

  defp resolve_command switches, command, values do
    [local: true, node: :bla, doma: :som]
  end

end
