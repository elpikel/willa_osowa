import Config

config :willa_osowa, WillaOsowaWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base:
    "aa0b/lNiqycNCvtvPPxVH3XQ8YAGTrzk2/P6343+YFVhG3EGkaNMEX5A6B0qtlAEOb2s7V+51iHRqtO+RXIXL7sKGbQcmJvTIQwv4+gCEVD",
  server: false

# In test, never hit the network — emails are captured by the Test adapter
# (assert with Swoosh.TestAssertions / assert_email_sent).
config :willa_osowa, WillaOsowa.Mailer, adapter: Swoosh.Adapters.Test

config :swoosh, :api_client, false

config :logger, level: :warning
