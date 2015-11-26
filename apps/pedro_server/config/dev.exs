use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :phoenix, Pedro.Phoenix.Endpoint,
  http: [port: 4000],
  debug_errors: true,
  code_reloader: true,
  cache_static_lookup: false,
  watchers: [node: ["lib/phoenix/node_modules/brunch/bin/brunch", "watch"]]

# Watch static and templates for browser reloading.
config :phoenix, Pedro.Phoenix.Endpoint,
  live_reload: [
    patterns: [
      ~r{lib/phoenix/priv/static/.*(js|css|png|jpeg|jpg|gif)$},
      ~r{lib/phoenix/web/views/.*(ex)$},
      ~r{lib/phoenix/web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"
