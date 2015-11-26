defmodule Pedro.Phoenix.PageController do
  use Pedro.Phoenix.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end
end
