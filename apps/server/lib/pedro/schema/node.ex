defmodule Pedro.Schema.Node do
  use Ecto.Model

  schema "node" do
    field :name
    field :started_at, Ecto.DateTime
    timestamps
  end

  @required_fields ~w(name)
  @optional_fields ~w()

  #TODO
  def changeset :create, params do
  end

  def changeset :update, model, params \\ :empty  do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

end
