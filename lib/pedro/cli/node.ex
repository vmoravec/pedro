defmodule Pedro.Cli.Node do
  alias Pedro.Runner

  def list options do
    case detect_node do
      {:local, name } -> Runner.local(name, :E, :b, [])
    end
  end

  defp detect_node do
    {:local, :os.getenv("PEDRO_SERVER") || "pedro-server"}
  end
end
