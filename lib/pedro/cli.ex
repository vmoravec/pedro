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
        -> detect_action(switches, commands)

      _ -> help
    end
  end

  def help do
    IO.puts "Pedro help: comes soon"
  end

  def detect_action switches, commands do
    [ command | values ] = commands
    try do
      #[ module, function ] = String.split(command, ".")
      cmd = case String.split(command, ".") do
        [ module, function ] -> detect_module(module, function)
        [ module ]           -> detect_module(module)
      end

      params =  values
    # FIXME Do not call the commander here, this should be
    # done in the Cli.* modules that need to decide when to trigger
    #   * a local node code execution
    #   * a http request to a remote node

    # Both access methods should return the same structure of data to
    # minimize the effort of showing them to user in terminal
    Pedro.Commander.execute(:local, cmd)
    rescue
      [ MatchError ] ->
        IO.puts "Unknown command: #{command}"
    end
  end

  def detect_module module, function do
    mod = Enum.join([__MODULE__, String.capitalize(module)], ".") |> String.to_atom
    func = function || :default
    { mod, func }
  end

  def detect_module module do
  end

end
