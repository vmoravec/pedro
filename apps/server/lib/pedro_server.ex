defmodule Pedro.Server do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    update_node

    children = [
      # supervisor(Pedro.Manager, []),
      # Define workers and child supervisors to be supervised
      worker(Pedro.Repo, []),
      worker(Pedro.Command, []),
      worker(Pedro.Query, [])
      # worker(PedroServer.Worker, [arg1, arg2, arg3])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Pedro.Server.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Pedro.Endpoint.config_change(changed, removed)
    :ok
  end

  def update_node do
    :net_kernel.start([:"server@pedro", :shortnames])
  end
end
