defmodule Pedro.PageController do
  use Pedro.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
