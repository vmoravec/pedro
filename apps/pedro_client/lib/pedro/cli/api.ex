defmodule Pedro.Client.Cli.Api do
  @version "v1"
  @port "3000"
  @api_prefix "/api/"

  def get path, env do
    build_request_path(:get, path, env)
  end

  defp build_request_path method, path, env do
    version = env[:api_version] || @version
    module = :"#{__MODULE__}.#{String.capitalize(version)}"
    url = env[:api_url] <> ":#{@port}" <> @api_prefix <> version <> path
    case Kernel.apply(module, :send_request, [method, url, path]) do
      {:ok, response }    -> {response, Keyword.merge(env, request_url: url) }
      {:error, response } -> {response, Keyword.merge(env, request_url: url) }
    end
  end
end
