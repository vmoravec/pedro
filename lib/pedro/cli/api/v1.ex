defmodule Pedro.Cli.Api.V1 do
  use HTTPotion.Base

  def process_url url do
    "http://manacor.suse.cz:3000/api/v1/" <> url
  end

  def process_request_headers headers do
    Dict.put(headers, :"User-Agent", "pedro-client")
  end

  def process_response_body(body) do
    body
  end
end
