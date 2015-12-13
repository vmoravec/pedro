# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

defmodule MixConfigHelpers do
  def detect_node_name do
    :os.getenv("PEDRO_NODE", to_string("master@pedro"))
  end

  def detect_node_type do
    :os.getenv("PEDRO_TYPE", "master")
  end
end

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for third-
# party users, it should be done in your mix.exs file.

# Sample configuration:
#
#     config :logger, :console,
#       level: :info,
#       format: "$date $time [$level] $metadata$message\n",
#       metadata: [:user_id]

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
#     import_config "#{Mix.env}.exs"
config :pedro_server,
  node_name: MixConfigHelpers.detect_node_name,
  node_type: "master"

# Configure your database
config :pedro_server, Pedro.Repo,
  adapter: Sqlite.Ecto,
  database: "db/pedro_dev.sqlite",
  pool_size: 10


