defmodule Pedro.NodeService do
  use Pedro.Service

  def get_status do
    query fn ->
      # Repo.get(Node, :local)
    end
  end

  def update_name name do
    result = command fn ->
      Logger.info "hello"
      [name: name]
    end

    # changeset = Node.changeset Repo.get!(Node, id), params["user"]
    # Repo.update(changeset)
  end
end
