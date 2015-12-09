defmodule Pedro.Schema.Node do
  use Pedro.Model

  schema "node" do
    field :name
    field :started_at, Ecto.DateTime
    timestamps
  end

  @repo Pedro.Repo
  @required_fields ~w(name)
  @optional_fields ~w()

  def start! do
    pupdate(%{started_at: Ecto.DateTime.local})
  end

  def pupdate(params) when is_map(params) do
    pupdate(@repo, params[:id], Map.delete(params, :id))
  end

  def pupdate(params) when is_list(params) do
    pupdate(@repo, params[:id], Keyword.delete(params, :id))
  end

  def pupdate id, params do
    pupdate(@repo, id, params)
  end

  def pupdate(repo, id, params) when is_map(params) do
    changeset(:update, Map.merge(params, %{id: id}))
   #repo.update(changeset(:update, Map.merge(params, %{id: id})))
  end

  def pupdate(repo, id, params) when is_list(params) do
    params = Enum.into(params, %{id: id})
    changeset(:update, params)
  # repo.update(changeset(:update, params))
  end

  def changeset :create, params do
    %Pedro.Schema.Node{started_at: Ecto.DateTime.local}
  end

  def changeset :update, params \\ :empty  do
    __MODULE__
    |> cast(params, @required_fields, @optional_fields)
  end

end
