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
    IO.inspect switches
    IO.inspect commands
    [ command | values ] = commands
    [ module, fun ] = String.split(command, ".")
    module_name = String.to_atom("Elixir.Pedro.Cli.#{String.capitalize(module)}")
    IO.inspect module_name
    IO.inspect fun
    Kernel.apply(module_name, String.to_atom(fun), [])
    # FIXME Do not call the commander here, this should be
    # done in the Cli.* modules that need to decide when to trigger
    #   * a local node code execution
    #   * a http request to a remote node

    # Both access methods should return the same structure of data to
    # minimize the effort of showing them to user in terminal
   #Pedro.Commander.execute(:local, cmd)
  end

  def detect_module module, function do
    mod = Enum.join([__MODULE__, String.capitalize(module)], ".") |> String.to_atom
    func = function || :default
    Kernel.apply(mod, func, [])
  end

  def detect_module module do
  end

end
