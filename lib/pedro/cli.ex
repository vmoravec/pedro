defmodule Pedro.Cli do
  def main(argv) do
    IO.puts inspect argv
    IO.puts inspect Pedro.Supervisor
    argv
  end
end
