defmodule Pedro.Server do
  use Application
  alias Pedro.Schema.Node

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Define workers and child supervisors to be supervised
      worker(Pedro.Repo, []),
      worker(Pedro.Command, []),
      worker(Pedro.Query, [])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Pedro.Server.Supervisor]
    supervisor = Supervisor.start_link(children, opts)

    update_node_in_repo

    supervisor
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Pedro.Endpoint.config_change(changed, removed)
    :ok
  end

  def update_node_in_repo do
    node = case Node.current do
      nil     -> insert_node_to_repo
      %Node{} -> Node.mark_current_as_started
      err     -> raise "Could not have loaded pedro node from db: #{inspect err}"
    end
    {:ok, node } = node
    :net_kernel.start([String.to_atom(node.name), :shortnames])
  end

  def insert_node_to_repo do
    node_name = Application.get_env(:pedro_server, :node_name)
    new_node = Node.create(%{
      name: node_name,
      type: Application.get_env(:pedro_server, :node_type)
    })
    :net_kernel.start([String.to_atom(node_name), :shortnames])
    new_node
  end

end
