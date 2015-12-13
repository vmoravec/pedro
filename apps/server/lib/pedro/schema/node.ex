defmodule Pedro.Schema.Node do
  use Pedro.Model

  schema "nodes" do
    field :name
    field :type
    field :started_at, Ecto.DateTime
    timestamps
  end

  @required_fields ~w(name started_at type)
  @optional_fields ~w()

  def mark_current_as_started do
    change(:update, current, %{started_at: Ecto.DateTime.local})
    |> repo.update
  end

  def current do
    repo.get_by(Node,
    %{name: Application.get_env(:pedro_server, :node_name),
      type: Application.get_env(:pedro_server, :node_type)
    })
  end

  def create params do
    new = change(
      :create, %Node{}, %{
        name: to_string(params[:name]),
        type: to_string(params[:type]),
        started_at: Ecto.DateTime.local
      }
    )
    if new.valid? do
      new |> repo.insert
    else
      {:error, new.errors}
    end
  end

  def change :create, model, params do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_name_uniqueness(params)
  end

  def change :update, model, params \\ :empty  do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_name_uniqueness(params)
  end

  defp validate_name_uniqueness model, params do
    adapter_data = Application.get_env(:pedro_server, Pedro.Repo, :adapter)
    case adapter_data[:adapter] do
      Sqlite.Ecto            ->
        validate_node(model, params)
      Ecto.Adapters.Postgres ->
        unique_constraint(model, :name, name: :nodes_name_index)
        |> validate_node(params)
    end
  end

  defp validate_node model, params do
    record = repo.get_by(Node, Map.delete(params, :started_at))
    case params[:name] do
      nil  -> model
      ""   -> model
      name ->
        validate_name(model, record, params)
        |> validate_type(record, params)
    end
  end

  defp validate_name model, record, params do
    if record do
      if record.name == params[:name] && record.type == params[:type] do
        add_error(model, :name, "already exists for this type")
      else
        model
      end
    else
      model
    end
  end

  defp validate_type model, record, params do
    if record do
      if record.type == "master" do
        add_error(model, :type, "only a single master is allowed")
      else
        model
      end
    else
      model
    end
  end

end
