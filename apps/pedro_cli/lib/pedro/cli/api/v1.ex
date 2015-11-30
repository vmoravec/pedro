defmodule Pedro.Cli.Api.V1 do
  use HTTPoison.Base

  def send_request method, url, path do
    Kernel.apply(__MODULE__, method, [url <> path])
  end

end
