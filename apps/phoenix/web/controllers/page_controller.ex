defmodule Pedro.PageController do
  use Pedro.Web, :controller

  def index conn, _params  do
    render(conn, "index.html")
  end

  def status conn, _params do
    conn
    |> put_flash(:info, "Pedro status is here")
    |> put_flash(:error, "Pedro status is here")
    |> render(:status)
  end

end
