defmodule Pedro.Client do
  # as fu
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Define workers and child supervisors to be supervised
      # worker(Pedro.Worker, [arg1, arg2, arg3])
      worker(Pedro.Client.Cli.RemoteService, [])
    ]
    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Pedro.Client.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
