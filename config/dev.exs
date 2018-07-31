use Mix.Config

config :zdashboard, :environment, :dev

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :zdashboard, ZdashboardWeb.Endpoint,
  http: [port: 8000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: [node: ["yarn", "run", "start:watch",
                    cd: Path.expand("../assets", __DIR__)]]

# Watch static and templates for browser reloading.
config :zdashboard, ZdashboardWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$},
      ~r{priv/gettext/.*(po)$},
      ~r{lib/gsmlg_web/views/.*(ex)$},
      ~r{lib/gsmlg_web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Configure your database
config :zdashboard, Zdashboard.Repo,
  adapter: EctoMnesia.Adapter

config :mnesia, :dir, 'priv/data/mnesia/dev'
