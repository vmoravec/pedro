defmodule Pedro.Schema.Node do
  use Pedro.Model

  schema "node" do
    field :name
    field :type
    field :started_at, Ecto.DateTime
    timestamps
  end

  @required_fields ~w(name started_at type)
  @optional_fields ~w()

  def mark_started do
    current = get_current
    changeset(:update, current, %{started_at: Ecto.DateTime.local})
    |> repo.update
  end

  def get_current do
    node_name = Application.get_env(:pedro_server, :node_name)
    node_type = Application.get_env(:pedro_server, :node_type)
    repo.get_by(Node, %{name: to_string(node_name), type: to_string(node_type)})
  end

  def insert_node node_name, node_type do
    changeset(:create, %{name: to_string(node_name), type: to_string(node_type)})
    |> repo.insert
  end

  def changeset :create, params do
    %Node{
      name: params[:node_name],
      type: params[:node_type],
      started_at: Ecto.DateTime.local
    }
    |> cast(params, @required_fields, @optional_fields)
  end

  def changeset :update, model, params \\ :empty  do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

end
