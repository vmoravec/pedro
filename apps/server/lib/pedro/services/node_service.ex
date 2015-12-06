defmodule NodeService do
  use Pedro.Service

  alias Pedro.Schema.Node

  def local_node do
  end

  def find_node name do
    query fn ->
      # Repo.get(Node, )
    end
  end

  def update_name name do
    command fn ->
    # changeset = Node.changeset Repo.get!(Node, id), params["user"]
    # Repo.update(changeset)
    end
  end
end
