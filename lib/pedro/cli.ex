defmodule Pedro.Cli do
  def main(argv) do
    IO.puts "Pedro is saying"
    IO.puts inspect argv
    receive do
    end
    argv
  end
end
