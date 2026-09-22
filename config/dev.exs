import Config

config :willa_osowa, WillaOsowaWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4000],
  check_origin: false,
  code_reloader: false,
  debug_errors: true,
  secret_key_base:
    "aa0b/lNiqycNCvtvPPxVH3XQ8YAGTrzk2/P6343+YFVhG3EGkaNMEX5A6B0qtlAEOb2s7V+51iHRqtO+RXIXL7sKGbQcmJvTIQwv4+gCEVD",
  server: true

# In dev, leads are captured by the local mailbox (viewable at /dev/mailbox)
# rather than actually sent. Disable the Swoosh API client since the Local
# adapter doesn't need it.
config :willa_osowa, dev_routes: true

config :swoosh, :api_client, false

config :logger, :console, format: "[$level] $message\n"

config :phoenix, :stacktrace_depth, 20
config :phoenix, :plug_init_mode, :runtime
