defmodule Pedro.Api.V1 do
  use HTTPotion.Base

  def process_url url, api_version \\ :v1 do
    "http://manacor.suse.cz:3000/api/#{api_version}/" <> url
  end

  def process_request_headers headers do
    Dict.put(headers, :"User-Agent", "pedro-client")
  end

  def process_response_body(body) do
    body
  end
end
