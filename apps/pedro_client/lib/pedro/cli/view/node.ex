defmodule PedroClient.Cli.View.Node do
  def status response do
    IO.inspect response.data.body
  end

  def list response do
    if response.ok?, do: IO.puts "Success"
  end
end
