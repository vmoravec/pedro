defmodule Pedro.Repo do
  use Ecto.Repo, otp_app: :pedro_server, adapter: Sqlite.Ecto
end
