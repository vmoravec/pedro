defmodule PedroClient.Cli.Api do
  @version :v1
  @url  "localhost"
  @port "5511"

  def get path, params \\ [] do
    version = params[:version] || @version |> Atom.to_string |> String.capitalize
    module = :"#{__MODULE__}.#{version}"
    case Kernel.apply(module, :get, [path, params]) do
      {:ok, response } -> response
    end
  end

  defp build_request params do
  end
end
